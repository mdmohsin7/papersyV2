import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:papersy/business/core/auth/models/auth_state.dart';

import '../../../main_state.dart';

class CheckAuthAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    User user = FirebaseAuth.instance.currentUser;
    return state.copy(
      authState: AuthState(user: user, isEmailSent: false),
    );
  }
}
