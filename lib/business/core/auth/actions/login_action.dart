import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../main_state.dart';
import '../models/auth_state.dart';

class LoginAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginAction({@required this.email, @required this.password});

  @override
  Future<AppState> reduce() async {
    var login = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email ?? this.email, password: password ?? this.password);
    await store
        .waitCondition((state) => login.user != null)
        .then(
          (value) => dispatch(
            NavigateAction.popUntilRouteName("/"),
          ),
        );
    return state.copy(
      wait: Wait(),
      authState: AuthState(user: login.user),
    );
  }

  @override
  Object wrapError(error) {
    String e = error.toString();
    return UserException(e.substring(e.indexOf(']') + 1, e.length),
        cause: error);
  }

  @override
  void before() => dispatch(WaitAction.add("authenticating"));

  @override
  void after() => dispatch(WaitAction.remove("authenticating"));
}

class ValidateAction extends ReduxAction<AppState> {
  final GlobalKey<FormState> key;
  final String email;
  final String password;

  ValidateAction({this.key, this.email, this.password});

  @override
  AppState reduce() {
    if (key.currentState.validate()) {
      dispatch(LoginAction(email: email, password: password));
    }
    return null;
  }
}
