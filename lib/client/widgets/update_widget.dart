import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/validators.dart';
import 'package:papersy/client/screens/profile/profile_connector.dart';
import 'package:papersy/client/widgets/text_form_field.dart';

import '../../sizeconfig.dart';

class UpdateWidget extends StatefulWidget {
  final String title;
  final Function(String, String) onSubmit;
  final bool isUpdating;

  const UpdateWidget({Key key, this.title, this.onSubmit, this.isUpdating})
      : super(key: key);

  @override
  _UpdateWidgetState createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _currentPass = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    return StoreConnector<AppState, PVM>(
      vm: ProfileVM(),
      builder: (context, pvm) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (c) => widget.title == "Update Email",
            widgetBuilder: (c) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: _height * 3.5, right: _height * 3.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: CustomTextField(
                    autoValidate: true,
                    hint: "New Email Address",
                    icon: Icons.email,
                    isEnabled: true,
                    isObscure: false,
                    validator: (e) => validateEmail(e),
                    controller: _email,
                  ),
                ),
                SizedBox(
                  height: _height * 1.5,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: _height * 3.5, right: _height * 3.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: CustomTextField(
                    autoValidate: true,
                    hint: "Confirm Email Address",
                    icon: Icons.email,
                    isEnabled: true,
                    isObscure: false,
                    validator: (s) {
                      if (s != _email.text) {
                        return "The email address does not match";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: _height * 1.5,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: _height * 3.5, right: _height * 3.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: CustomTextField(
                    hint: "Current Password",
                    icon: Icons.lock,
                    isEnabled: true,
                    isObscure: true,
                    validator: (s) {},
                    controller: _currentPass,
                  ),
                ),
                SizedBox(
                  height: _height * 2.6,
                ),
                pvm.isUpdating
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_height * 1.3),
                        ),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline5.color),
                        ),
                        onPressed: () {
                          widget.onSubmit(_email.text, _currentPass.text);
                        },
                      )
              ],
            ),
            fallbackBuilder: (c) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: _height * 3.5, right: _height * 3.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: CustomTextField(
                    autoValidate: true,
                    hint: "Current Password",
                    icon: Icons.lock,
                    isEnabled: true,
                    isObscure: true,
                    validator: (s) {
                      if (s.length < 1) {
                        return "This field can\'t be empty";
                      } else {
                        return null;
                      }
                    },
                    controller: _currentPass,
                  ),
                ),
                SizedBox(
                  height: _height * 1.5,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: _height * 3.5, right: _height * 3.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: CustomTextField(
                    autoValidate: true,
                    hint: "New Password",
                    icon: Icons.lock,
                    isEnabled: true,
                    isObscure: true,
                    validator: (s) {
                      if (s.length < 3) {
                        return "It should be atleast 4 letters long";
                      } else if (s == _currentPass.text) {
                        return "New password can\'t be your old password";
                      } else {
                        return null;
                      }
                    },
                    controller: _newPass,
                  ),
                ),
                SizedBox(
                  height: _height * 1.5,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: _height * 3.5, right: _height * 3.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: CustomTextField(
                    autoValidate: true,
                    hint: "Confirm New Password",
                    icon: Icons.lock,
                    isEnabled: true,
                    isObscure: true,
                    validator: (s) {
                      if (s != _newPass.text) {
                        return "Password does not match";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: _height * 2.6,
                ),
                pvm.isUpdating
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_height * 1.3),
                        ),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline5.color),
                        ),
                        onPressed: () {
                          widget.onSubmit(_currentPass.text, _newPass.text);
                        },
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
