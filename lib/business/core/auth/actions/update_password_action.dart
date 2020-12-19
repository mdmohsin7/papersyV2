import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:papersy/business/core/auth/models/auth_state.dart';
import 'package:papersy/business/main_state.dart';

class UpdatePasswordAction extends ReduxAction<AppState> {
  final String currentPass;
  final String newPass;

  UpdatePasswordAction({this.currentPass, this.newPass});
  @override
  Future<void> before() async {
    // String name = await FirebaseAuth.instance.currentUser.displayName;
    // if (name != null) {
    //   throw UserException(
    //       "You have signed in with your Google account. As the authentication is handled by Google, we can\'t change the password of your Google account.");
    // }
    String email = FirebaseAuth.instance.currentUser.email;
    EmailAuthCredential credential =
        EmailAuthProvider.credential(email: email, password: currentPass);
    try {
      dispatch(WaitAction.add("updating"));
      await FirebaseAuth.instance.currentUser
          .reauthenticateWithCredential(credential);
    } catch (e) {
      dispatch(WaitAction.remove("updating"));
      throw e;
    }
  }

  @override
  Future<AppState> reduce() async {
    User user;
    await FirebaseAuth.instance.currentUser.updatePassword(newPass);
    user = FirebaseAuth.instance.currentUser;
    dispatch(NavigateAction.pop());
    return state.copy(
        authState: AuthState(
      isEmailSent: state.authState.isEmailSent,
      user: user,
    ));
  }

  @override
  void after() {
    dispatch(WaitAction.remove("updating"));
  }

  @override
  Object wrapError(error) {
    return UserException(error.toString(), cause: error);
  }
}
