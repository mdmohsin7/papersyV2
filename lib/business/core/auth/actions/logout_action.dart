import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:papersy/business/core/auth/models/auth_state.dart';
import 'package:papersy/business/main_state.dart';

class LogOutAction extends ReduxAction<AppState> {
  @override
  void before() {
    dispatch(WaitAction.add("logging out"));
  }

  @override
  Future<AppState> reduce() async {
    await FirebaseAuth.instance.signOut().then((value) {
      NavigateAction.popUntil((home) => true );
      dispatch(WaitAction.remove("logging out"));
    });
    await store.waitCondition(
        (state) => state.wait.isWaitingFor("logging out") == false);
    return state.copy(
      authState: AuthState.initialState(),
    );
  }
}
