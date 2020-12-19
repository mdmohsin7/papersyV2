import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final Widget child;
  final bool isYear;

  const DropDownWidget({Key key, this.child, this.isYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.5,
            color: Colors.black,
          )
        ],
      ),
      height: isYear ? 40 : 45,
      width: isYear ? 100 : 190,
      child: child,
    );
  }
}
