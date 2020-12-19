import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  final List items;
  final String value;
  final Function(String) onChanged;
  final String hint;
  final bool customHeight;

  const DropDownMenu(
      {Key key,
      this.items,
      this.onChanged,
      this.value,
      this.hint,
      this.customHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Container(
        padding:const EdgeInsets.only(
          left: 6.0,
          right: 4.0,
          top: 6.0,
          bottom: 6.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(
            spreadRadius: 0.3,
          )],
        ),
        height: customHeight ? 40 : 45,
        width: customHeight ? 100 : 190,
        child: DropdownButton(
          elevation: 2,
          isExpanded: true,
          isDense: false,
          underline: Container(
            height: 1,
            color:  Colors.transparent,
          ),
          value: value,
          hint: Text("  " + hint),
          items: items
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (val) {
            onChanged(val);
          },
        ),
      ),
    );
  }
}
