import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/core/auth/models/auth_state.dart';
import 'package:papersy/business/main_state.dart';

class SignUpAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  SignUpAction({this.email, this.password});
  bool detailsUpdated = false;
  @override
  Future<AppState> reduce() async {
    var signup = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (signup.user != null) {
      FirebaseFirestore.instance.collection("Users").doc(signup.user.uid).set({
        "id": signup.user.uid,
        "email": signup.user.email,
      }).then((value) => detailsUpdated = true, onError: (error) {
        throw UserException(error.toString());
      });
    }
    await store
        .waitCondition((state) => signup.user != null)
        .then((value) => dispatch(NavigateAction.popUntilRouteName("/")));
    return state.copy(
      wait: Wait(),
      authState: AuthState(user: signup.user),
    );
  }

  @override
  Object wrapError(error) {
    String e = error.toString();
    return UserException(e.substring(e.indexOf("]") + 1, e.length),
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
      dispatch(SignUpAction(email: email, password: password));
    }
    return null;
  }
}
