import 'package:flutter/material.dart';

import '../../sizeconfig.dart';

class DropDownWidget extends StatelessWidget {
  final Widget child;
  final bool isYear;

  const DropDownWidget({Key key, this.child, this.isYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
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
      height: isYear ? _height * 6.8 : _height * 7.4,
      width: isYear ? _width * 32 : _width * 72,
      child: child,
    );
  }
}
