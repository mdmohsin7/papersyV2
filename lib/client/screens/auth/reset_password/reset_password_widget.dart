import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/validators.dart';
import '../../../../sizeconfig.dart';
import 'reset_password_connector.dart';
import 'package:papersy/client/widgets/text_form_field.dart';


class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget();
  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  GlobalKey<FormState> _formKey;

  TextEditingController _emailController = TextEditingController();
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
  _ResetPasswordWidgetState() {
    _formKey = GlobalKey<FormState>();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StoreConnector<AppState, RPVM>(
      vm: ResetPasswordVM(),
      builder: (context, rpvm) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0.0,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: _height * 10,
                      ),
                      Text(
                        "Forgot Your Password?",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 6,
                      ),
                      Padding(
                        padding:
                             EdgeInsets.only(top: _height* 2, left: _width *10, right: _width *10),
                        child: Text(
                          "Please enter your email address. We will send you an email to reset your password",
                          style: Theme.of(context).textTheme.subtitle2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: _height * 2,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: _width*7,right: _width*7),
                        child: CustomTextField(
                          hint: "Email Address",
                          isEnabled: true,
                          validator: (s) => validateEmail(s),
                          controller: _emailController,
                          icon: Icons.email,
                        ),
                      ),
                      SizedBox(
                        height: _height * 4,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          height: _height * 6.5,
                          width: _width * 38.5,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            color: Theme.of(context).buttonColor,
                            child: Text(
                              rpvm.isEmailSent ? "Email Sent" : "Send Email",
                              style: Theme.of(context).textTheme.button,
                            ),
                            onPressed: rpvm.isEmailSent ? null: () {
                              // if (_formKey.currentState.validate()) {
                                
                              // }
                              rpvm.sendEmail(_emailController.text);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
