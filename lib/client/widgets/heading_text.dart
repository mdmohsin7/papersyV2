import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text1;
  final String text2;
  const HeadingText({@required this.text1, @required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text1,
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.headline6.color),
          ),
          Text(
            text2,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.bodyText1.color),
          ),
        ],
      ),
    );
  }
}
