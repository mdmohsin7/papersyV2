import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:papersy/business/core/auth/actions/google_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/client/screens/auth/auth_widget.dart';

class AuthVM extends VmFactory<AppState, AuthWidget> {
  @override
  AVM fromStore() {
    return AVM(
      signIn: () => dispatch(GoogleAction()),
    );
  }
}

class AVM extends Vm {
  final VoidCallback signIn;

  AVM({this.signIn});
}
