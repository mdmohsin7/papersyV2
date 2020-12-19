import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          child: Text('Papersy'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text("Notes"),
          onTap: (){},
        ),
         ListTile(
          title: Text("Question Papers"),
          onTap: (){},
        ),
      ],
    );
  }
}
