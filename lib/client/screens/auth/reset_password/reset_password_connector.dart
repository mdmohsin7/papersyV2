import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/auth/actions/reset_password_action.dart';
import 'package:papersy/business/main_state.dart';
import 'reset_password_widget.dart';

class ResetPasswordVM extends VmFactory<AppState, ResetPasswordWidget> {
  @override
  RPVM fromStore() {
    return RPVM(
      isEmailSent: state.authState.isEmailSent,
      sendEmail: (email) => dispatch(SendEmailAction(email: email)),
    );
  }
}

class RPVM extends Vm {
  final bool isEmailSent;
  final Function(String) sendEmail;

  RPVM({this.isEmailSent, this.sendEmail}) : super(equals: [isEmailSent]);
}
