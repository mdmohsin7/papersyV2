import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/core/auth/actions/login_action.dart';
import 'package:papersy/business/main_state.dart';
import 'login_widget.dart';

class LoginVM extends VmFactory<AppState, LoginWidget> {
  LoginVM(widget) : super(widget);
  bool isAuthenticating;
  Function(String, String, GlobalKey<FormState>) login;

  @override
  LVM fromStore() {
    return LVM(
      isAuthenticating: state.wait == null ? false : state.wait.isWaiting,
      login: (email, password, key) =>
          dispatch(ValidateAction(email: email, password: password, key: key)),
    );
  }
}

class LVM extends Vm {
  final bool isAuthenticating;
  final Function(String, String, GlobalKey<FormState>) login;

  LVM({this.isAuthenticating, this.login}):super(equals: [isAuthenticating]);
}
