import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/auth/actions/update_password_action.dart';
import 'package:papersy/business/core/auth/actions/update_email_action.dart';
import 'package:papersy/business/main_state.dart';
import '../profile/profile_widget.dart';

class ProfileVM extends VmFactory<AppState, ProfileWidget> {
  @override
  PVM fromStore() {
    return PVM(
      email: state.authState.user.email,
      updateEmail: (email, pass) =>
          dispatch(UpdateEmailAction(newEmail: email, currentPass: pass)),
      updatePassword: (currentPass, newPass) => dispatch(
        UpdatePasswordAction(currentPass: currentPass, newPass: newPass),
      ),
      isUpdating: state.wait.isWaitingFor("updating"),
    );
  }
}

class PVM extends Vm {
  final String email;
  final Function(String, String) updateEmail;
  final Function(String, String) updatePassword;
  final bool isUpdating;

  PVM({this.isUpdating, this.email, this.updateEmail, this.updatePassword})
      : super(equals: [email, isUpdating]);
}
