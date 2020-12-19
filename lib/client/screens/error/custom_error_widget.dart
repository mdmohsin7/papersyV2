import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Ah snap! Something went wrong."),
      ),
    );
  }
}
