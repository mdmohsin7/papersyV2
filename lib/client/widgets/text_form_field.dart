import 'package:flutter/material.dart';

import '../../sizeconfig.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function(String) validator;
  final TextEditingController controller;
  final bool isEnabled;
  final IconData icon;
  final bool isObscure;
  final bool autoValidate;

  const CustomTextField(
      {Key key,
      this.hint,
      this.validator,
      this.controller,
      this.isEnabled,
      this.icon,
      this.isObscure = false,
      this.autoValidate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 3.5,
          ),
          Icon(
            icon,
            color: Theme.of(context).accentIconTheme.color,
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 3.5,
          ),
          Expanded(
            child: TextFormField(
              autovalidateMode: autoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              obscureText: isObscure,
              validator: (s) => validator(s),
              controller: controller,
              enabled: isEnabled,
              decoration:
                  InputDecoration(hintText: hint, border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: 14.0,
          ),
        ],
      ),
    );
  }
}
