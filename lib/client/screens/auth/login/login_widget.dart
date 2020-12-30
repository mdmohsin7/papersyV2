import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/validators.dart';
import 'package:papersy/client/widgets/heading_text.dart';
import 'package:papersy/client/widgets/text_form_field.dart';
import 'package:papersy/sizeconfig.dart';

import '../login/login_connector.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget();
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  GlobalKey<FormState> formkey;

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  double _height = SizeConfig.blockSizeVertical;
  double _width = SizeConfig.blockSizeHorizontal;
  _LoginWidgetState() {
    formkey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StoreConnector<AppState, LVM>(
        vm: LoginVM(widget),
        builder: (context, vm) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Builder(
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: _height * 25,
                      ),
                      HeadingText(
                        text1: "Welcome back!",
                        text2: "Please login to your account.",
                      ),
                      SizedBox(
                        height: _height * 4.5,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: _height * 3.8),
                        child: Container(
                          child: Form(
                            key: formkey,
                            onChanged: () {
                              formkey.currentState.save();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CustomTextField(
                                  controller: _emailController,
                                  hint: "Email Address",
                                  icon: Icons.email,
                                  isEnabled: vm.isAuthenticating ? false : true,
                                  validator: (e) => validateEmail(e),
                                ),
                                SizedBox(
                                  height: _height * 1.4,
                                ),
                                CustomTextField(
                                  isObscure: true,
                                  controller: _passwordController,
                                  hint: "Password",
                                  icon: Icons.lock,
                                  isEnabled: vm.isAuthenticating ? false : true,
                                  validator: (e){
                                  if (e.length < 1) {
                                    return "This field can\'t be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: _height * 3.5),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (c) => vm.isAuthenticating,
                        widgetBuilder: (c) => CircularProgressIndicator(),
                        fallbackBuilder: (c) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Container(
                                height: _height * 7,
                                width: _width * 36.5,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(_height * 2.5),
                                    ),
                                  ),
                                  color: Theme.of(context).buttonColor,
                                  child: Text(
                                    "Login",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  onPressed: () {
                                    vm.login(_emailController.text,
                                        _passwordController.text, formkey);
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "reset");
                              },
                              child: Text(
                                "Reset Password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: _height * 2.3,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _height * 8.5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "signup");
                        },
                        child: Text(
                          "Don't have an account? Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _height * 2.4,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
  }
}
