import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Color(0xffe0e0e0),
    colorScheme: ColorScheme.light(),
    primaryColor: Color(0xff8F86F1),
    accentColor: Color(0xff7367F0),
    cardColor: Color(0xffFFFFFF),
    buttonColor: Color(0xff8F86F1),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    accentIconTheme: IconThemeData(
      color: Colors.black,
    ),
    primaryIconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.black),
      subtitle2: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Color(0xffa3a3a3)),
      button: TextStyle(color: Colors.white),
    ),
    tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.white,width: 2.0)
      ),
      labelColor: Colors.white,
      unselectedLabelColor:Color(0xffe0e0e0),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xff404852),
    colorScheme: ColorScheme.dark(),
    primaryColor: Color(0xff8F86F1),
    accentColor: Color(0xff7367F0),
    backgroundColor: Color(0xff3D4051),
    cardColor: Color(0xff1D202B),
    buttonColor: Color(0xff7367F0),
    iconTheme: IconThemeData(color: Color(0xff1D202B)),
    accentIconTheme: IconThemeData(color: Colors.white),
    primaryIconTheme: IconThemeData(color: Colors.yellow[700]),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Color(0xffB0B4C9)),
      button: TextStyle(color: Colors.white),
    ),
      tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.black,width: 2.0)
      ),
      labelColor: Colors.black,
      unselectedLabelColor:Color(0xff3D4051),
    ),
  );
}

