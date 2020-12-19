import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:papersy/business/core/auth/models/auth_state.dart';
import 'package:papersy/business/main_state.dart';

class SendEmailAction extends ReduxAction<AppState> {
  final String email;

  SendEmailAction({this.email});
  @override
  void before() {
    dispatch(WaitAction.add("sending"));
  }

  @override
  Future<AppState> reduce() async {
    var sent;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .whenComplete(() => sent = true);
    return state.copy(authState: AuthState(isEmailSent: sent));
  }
  @override
  void after() {
    dispatch(WaitAction.remove("sending"));
  }

  @override
  Object wrapError(error) {
    String e= error.toString();
    return UserException(e.substring(e.indexOf(']')+1,e.length), cause: error);
  }
}
