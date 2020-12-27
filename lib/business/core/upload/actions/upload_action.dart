import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart' as f;
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
      if (await state.uploadState.file.length() > 40000000) {
        throw UserException(Values.pdfSize);
      }
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
        'Notes/${v["Course"]}/${v["Branch"]}/${v["Semester"]}/${v["Uploader"]}/${v["Subject"]}';
    String pref =
        'Papers/${v["Course"]}/${v["Branch"]}/${v["Semester"]}/${v["Uploader"]}/${v["Subject"]}';

    f.FirebaseStorage fs =
        f.FirebaseStorage.instanceFor(bucket: ConfidentialData.papersBucketRef);
    f.FirebaseStorage fs2 =
        f.FirebaseStorage.instanceFor(bucket: ConfidentialData.notesBucketRef);
    var fsa = fs.ref(pref);
    var fsa2 = fs2.ref(nref);

    if (v["Type"] == "Notes") {
      await fsa2
          .putFile(state.uploadState.file)
          .whenComplete(
            () async => dwldUrl = await fsa2.getDownloadURL(),
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
            "u": "${v["min"] ?? 1}-${v["max"] ?? 5}",
            "isv": false,
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
    } else {
      await fsa
          .putFile(state.uploadState.file)
          .whenComplete(
            () async => dwldUrl = await fsa.getDownloadURL(),
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
          }).whenComplete(() async {
            await FirebaseInAppMessaging.instance.triggerEvent("verification");
            dispatch(WaitAction.remove("uploading"));
            dispatch(NavigateAction.pop());
          });
        },
      );
    }

    await store.waitCondition(
        (state) => state.wait.isWaitingFor("uploading") == false);
    return state.copy(
      wait: Wait(),
      uploadState: UploadState.initialState(),
    );
  }
}
