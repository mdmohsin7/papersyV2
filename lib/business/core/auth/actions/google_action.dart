import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:papersy/business/core/auth/models/auth_state.dart';

import '../../../main_state.dart';

class GoogleAction extends ReduxAction<AppState> {
  User user;
  @override
  Future<AppState> reduce() async {
    try {
      GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user = userCred.user;
      if (user != null) {
        FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
          {
            "email": user.email,
            "uid": user.uid,
            "t": "google",
          },
          SetOptions(
            merge: true,
          ),
        );
      }
    } catch (e) {
      throw e;
    }
    return state.copy(
      authState: AuthState(
        user: user,
        isEmailSent: state.authState.isEmailSent,
      ),
    );
  }

  @override
  void after() {
    dispatch(NavigateAction.popUntilRouteName("/"));
  }

  @override
  Object wrapError(error) {
    return UserException(error.toString(), cause: error);
  }
}
