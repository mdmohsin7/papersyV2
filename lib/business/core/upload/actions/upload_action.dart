import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart' as f;
import 'package:papersy/business/core/home/actions/check_auth_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/core/upload/models/upload_state.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/confidential/confidential_data.dart';

class UploadAction extends ReduxAction<AppState> {
  var sub;
  @override
  Future<void> before() async {
    sub = await Connectivity().checkConnectivity();
    if (sub == ConnectivityResult.none) {
      NavigateAction.pop();
      throw UserException(Values.noInternet);
    } else {
      if (state.uploadState.file != null) {
        if (await state.uploadState.file.length() > 40000000) {
          throw UserException(Values.pdfSize);
        }
      }

      await dispatchFuture(CheckAuthAction());
      dispatch(WaitAction.add("uploading"));
    }
  }

  @override
  Object wrapError(error) {
    print(error);
    return UserException("$error", cause: error);
  }

  @override
  Future<AppState> reduce() async {
    Map v = state.uploadState.selectedValues;
    String dwldUrl;
    String nref =
        'Notes/${v["Course"]}/${v["Branch"]}/${v["Semester"]}/${v["Uploader"]}/${v["Subject"]}_${DateTime.now().toString()}';
    String pref =
        'Papers/${v["Course"]}/${v["Branch"]}/${v["Semester"]}/${v["Uploader"]}/${v["Subject"]}_${DateTime.now().toString()}';
    String eref =
        'Extras/${v["Type"]}/${v["Course"]}/${v["Branch"]}/${v["Semester"]}/${v["Uploader"]}/${v["Subject"]}_${DateTime.now().toString()}';
    f.FirebaseStorage pfs =
        f.FirebaseStorage.instanceFor(bucket: ConfidentialData.papersBucketRef);
    f.FirebaseStorage nfs =
        f.FirebaseStorage.instanceFor(bucket: ConfidentialData.notesBucketRef);
    f.FirebaseStorage efs =
        f.FirebaseStorage.instanceFor(bucket: ConfidentialData.extrasBucketRef);
    f.Reference pfsr = pfs.ref(pref);
    f.Reference nfsr = nfs.ref(nref);
    f.Reference efsr = efs.ref(eref);
    var size = state.uploadState.file?.lengthSync();

    if (v["Type"] == "Notes") {
      await nfsr
          .putFile(state.uploadState.file)
          .whenComplete(
            () async => dwldUrl = await nfsr.getDownloadURL(),
          )
          .whenComplete(
        () async {
          var ref = await FirebaseFirestore.instance
              .collection("${v["Type"]}")
              .doc("${v["Course"]}")
              .collection("${v["Branch"]}")
              .doc("${v["Semester"]}")
              .collection("SEM${v["Semester"]}")
              .doc();
          await ref.set({
            "c": v["College"],
            "link": dwldUrl,
            "s": v["Subject"],
            "a": v["Uploader"],
            "u": "${v["min"] ?? 2}-${v["max"] ?? 4}",
            "isv": false,
            "uid": state.authState.user.uid,
            "si": size.toString(),
          }).whenComplete(
            () async {
              await FirebaseInAppMessaging.instance
                  .triggerEvent("verification");
              dispatch(WaitAction.remove("uploading"));
              dispatch(NavigateAction.pop());
            },
          );
        },
      );
    } else if (v["Type"] == "Question Papers") {
      await pfsr
          .putFile(state.uploadState.file)
          .whenComplete(
            () async => dwldUrl = await pfsr.getDownloadURL(),
          )
          .whenComplete(
        () async {
          await FirebaseFirestore.instance
              .collection("Papers")
              .doc("${v["Course"]}")
              .collection("${v["Branch"]}")
              .doc("${v["Semester"]}")
              .collection("SEM${v["Semester"]}")
              .doc()
              .set({
            "link": dwldUrl,
            "s": v["Subject"],
            "a": v["Uploader"],
            "y": v["Year"] == "Multiple Years"
                ? "${v["y1"] ?? 2017}-${v["y2"] ?? 2020}"
                : "${v["y3"] ?? 2020}",
            "isv": false,
            "uid": state.authState.user.uid,
            "si": size.toString(),
          }).whenComplete(() async {
            await FirebaseInAppMessaging.instance.triggerEvent("verification");
            dispatch(WaitAction.remove("uploading"));
            dispatch(NavigateAction.pop());
          });
        },
      );
    } else if (v["Type"] == "Tutorials") {
      await FirebaseFirestore.instance
          .collection("Extras")
          .doc("${v["Course"]}")
          .collection("${v["Branch"]}")
          .doc("${v["Semester"]}")
          .collection("SEM${v["Semester"]}")
          .doc()
          .set({
        "link": v["Link"],
        "s": v["Subject"],
        "a": v["Uploader"],
        "u": "${v["min"] ?? 2}-${v["max"] ?? 4}",
        "t": v["Type"],
        "isv": false,
        "uid": state.authState.user.uid,
      }).whenComplete(() async {
        await FirebaseInAppMessaging.instance.triggerEvent("verification");
        dispatch(WaitAction.remove("uploading"));
        dispatch(NavigateAction.pop());
      });
    } else {
      await efsr
          .putFile(state.uploadState.file)
          .whenComplete(
            () async => dwldUrl = await efsr.getDownloadURL(),
          )
          .whenComplete(
        () async {
          var ref = await FirebaseFirestore.instance
              .collection("Extras")
              .doc("${v["Course"]}")
              .collection("${v["Branch"]}")
              .doc("${v["Semester"]}")
              .collection("SEM${v["Semester"]}")
              .doc();
          await ref.set({
            "t": v["Type"],
            "link": dwldUrl,
            "s": v["Subject"],
            "a": v["Uploader"],
            "u": "${v["min"] ?? 2}-${v["max"] ?? 4}",
            "isv": false,
            "uid": state.authState.user.uid,
            "si": size.toString(),
          }).whenComplete(
            () async {
              await FirebaseInAppMessaging.instance
                  .triggerEvent("verification");
              dispatch(WaitAction.remove("uploading"));
              dispatch(NavigateAction.pop());
            },
          );
        },
      );
    }
    ;

    await store.waitCondition(
        (state) => state.wait.isWaitingFor("uploading") == false);
    return state.copy(
      wait: Wait(),
      uploadState: UploadState.initialState(),
    );
  }
}
