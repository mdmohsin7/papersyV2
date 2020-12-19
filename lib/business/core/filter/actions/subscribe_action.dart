import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:papersy/business/main_state.dart';

class SubscribeAction extends ReduxAction<AppState> {
  final String branch;
  final String sem;

  SubscribeAction({this.branch, this.sem});
  @override
  Future<AppState> reduce() async {
    if (state.filterState.getNotified) {
      print(branch + sem);
      var topic = branch + sem;
      await FirebaseMessaging.instance.subscribeToTopic("$topic");
    }
    return null;
  }
}
