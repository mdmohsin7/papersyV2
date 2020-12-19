import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:papersy/business/core/auth/models/auth_state.dart';
import 'package:papersy/business/main_state.dart';

class UpdateEmailAction extends ReduxAction<AppState> {
  final String newEmail;
  final String currentPass;

  UpdateEmailAction({this.newEmail, this.currentPass});
  @override
  Future<void> before() async {
    String name = FirebaseAuth.instance.currentUser.displayName;
    print("name: $name");

    String email = FirebaseAuth.instance.currentUser.email;
    EmailAuthCredential credential =
        EmailAuthProvider.credential(email: email, password: currentPass);
    try {
      // if (newEmail != null && currentPass != null && name != null) {
      //   throw UserException(
      //       "You have signed in with your Google account. Log out of this account and sign in back with the Google account of the email Id you want to use.");
      // }
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
    try {
      await FirebaseAuth.instance.currentUser.updateEmail(newEmail);
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      throw e;
    }
    await store
        .waitCondition((state) => user.email == newEmail)
        .then((value) => dispatch(NavigateAction.pop()));
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
