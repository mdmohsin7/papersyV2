import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/values.dart';

class ReportAction extends ReduxAction<AppState> {
  final DocumentReference ref;

  ReportAction({this.ref});

  @override
  Future<AppState> reduce() async {
    String uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection("Reports").doc().set({
        "uid": uid,
        "doc": ref.id,
        "p": ref.parent.path,
      }).whenComplete(() => throw UserException(Values.reported));
    } else if (uid == null) {
      throw UserException("You need to be signed in to be able to report anything.");
    }
    return null;
  }

  @override
  Object wrapError(error) {
    return UserException(error.toString());
  }
}
