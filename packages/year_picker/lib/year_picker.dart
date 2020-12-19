library year_picker;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class YearPicker extends StatefulWidget {
  YearPicker(
      {Key key,
      @required this.selectedDate,
      @required this.onChanged,
      @required this.firstDate,
      @required this.lastDate,
      this.fontFamily,
      this.dragStartBehavior = DragStartBehavior.start,
      })
      : 
        assert(onChanged != null),
        // assert(!firstDate.isAfter(lastDate)),assert(selectedDate != null),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a year.
  final ValueChanged<int> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;



  /// Font
  final String fontFamily;


  @override
  _YearPickerState createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return DropdownButton(
      isExpanded: true,
        isDense: false,
        underline: Container(
          height: 1,
          color: Colors.transparent,
        ),
      value: widget.selectedDate != null ?  widget.selectedDate.year : null,
      items: [
        for(int i = widget.firstDate.year; i <= widget.lastDate.year; i++)
          DropdownMenuItem(
            child: Text(i.toString()),
            value: i,
          ),
      ],
      onChanged: (int) => widget.onChanged(int),
      hint: Text("Year"),
    );
  }
}