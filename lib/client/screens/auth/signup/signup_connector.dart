import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/core/auth/actions/signup_acton.dart';
import 'package:papersy/business/main_state.dart';
import 'signup_widget.dart';

class SignupVM extends VmFactory<AppState, SignupWidget> {
  SignupVM() : super();

  @override
  SVM fromStore() {
    return SVM(
      isAuthenticating: state.wait == null ? false : state.wait.isWaiting,
      signUp: (email, password, key) =>
          dispatch(ValidateAction(email: email, password: password, key: key)),
    );
  }
}

class SVM extends Vm {
  final bool isAuthenticating;
  final Function(String, String, GlobalKey<FormState>) signUp;

  SVM({this.isAuthenticating, this.signUp}) : super(equals: [isAuthenticating]);
}
