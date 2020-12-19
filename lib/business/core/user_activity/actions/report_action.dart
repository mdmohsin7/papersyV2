import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:papersy/business/main_state.dart';

class ReportAction extends ReduxAction<AppState> {
  final String type;
  final String course;
  final String branch;
  final String sem;

  ReportAction({this.type, this.course, this.branch, this.sem});

  @override
  Future<AppState> reduce() async {
    String uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection("Reports").doc().set({
        "uid": uid,
        "t": type,
        "c": course,
        "s": sem,
      }).whenComplete(() => throw UserException(
          "Reported successfully. We will look into those notes/papers. If we don't find anything wrong or you reported them for fun/revenge/etc, we might ban your account based on your activity."));
    } else if(uid == null) {
      throw UserException("You need to be signed in to report notes/papers");
    }
    return null;
  }
  @override
  Object wrapError(error) {
    return UserException(error.toString());
  }
}
