import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/validators.dart';
import '../../../../sizeconfig.dart';
import 'signup_connector.dart';
import 'package:papersy/client/widgets/heading_text.dart';
import 'package:papersy/client/widgets/text_form_field.dart';



class SignupWidget extends StatefulWidget {
  const SignupWidget();
  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  GlobalKey<FormState> _formKey;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();
  double _height = SizeConfig.blockSizeVertical;
  double _width = SizeConfig.blockSizeHorizontal;
  _SignupWidgetState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StoreConnector<AppState, SVM>(
      vm: SignupVM(),
      builder: (context, svm) {
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
                      text1: "Let's get going!",
                      text2: "Please enter your details.",
                    ),
                    SizedBox(
                      height: _height * 4.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        child: Form(
                          key: _formKey,
                          onChanged: () {
                            _formKey.currentState.save();
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
                                isEnabled: svm.isAuthenticating ? false : true,
                                validator: (e) => validateEmail(e),
                              ),
                              SizedBox(
                                height: _height * 1.5,
                              ),
                              CustomTextField(
                                controller: _passwordController,
                                hint: "Password",
                                icon: Icons.lock,
                                isEnabled: svm.isAuthenticating ? false : true,
                                isObscure: true,
                                validator: (e) {
                                  if (e.length < 4) {
                                    return "It should be atleast 4 characters long";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: _height * 1.5,
                              ),
                              CustomTextField(
                                controller: _confirmpassController,
                                hint: "Confirm Password",
                                icon: Icons.lock,
                                isEnabled: svm.isAuthenticating ? false : true,
                                isObscure: true,
                                validator: (e) {
                                  if (e != _passwordController.text) {
                                    return "Password does not match";
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
                      conditionBuilder: (c) => svm.isAuthenticating,
                      widgetBuilder: (c) => CircularProgressIndicator(),
                      fallbackBuilder: (c) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                                  "Sign Up",
                                  style: Theme.of(context).textTheme.button,
                                ),
                                onPressed: () {
                                  svm.signUp(_emailController.text,
                                      _passwordController.text, _formKey);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height * 8.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Already have an account? Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).textTheme.headline6.color),
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
