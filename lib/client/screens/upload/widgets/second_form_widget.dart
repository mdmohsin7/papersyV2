import 'package:animations/animations.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/screens/upload/upload_connector.dart';
import 'package:papersy/client/widgets/drop_down_menu.dart';
import 'package:papersy/client/widgets/drop_down_widget.dart';
import 'package:papersy/sizeconfig.dart';

import 'package:year_picker/year_picker.dart' as picker;

class SecondFormWidget extends StatefulWidget {
  const SecondFormWidget();
  @override
  _SecondFormWidgetState createState() => _SecondFormWidgetState();
}

class _SecondFormWidgetState extends State<SecondFormWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List a = ["Single Year", "Multiple Years"];
    return StoreConnector<AppState, UVM>(
      vm: UploadVM(),
      builder: (context, uvm) {
        return Container(
          height: SizeConfig.blockSizeVertical * 76,
          child: Form(
            child: Column(
              children: [
                uvm.selectedValues["Type"] == "Notes"
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          Values.secondFormNotes,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          Values.secondFormPapers,
                          textAlign: TextAlign.center,
                        ),
                      ),
                Container(
                  child: DropDownMenu(
                    onChanged: (value) => uvm.onChanged("Subject", value),
                    customHeight: false,
                    hint: "Subject",
                    value: uvm.selectedValues["Subject"],
                    items: [
                      for (var course in uvm.courses.where((element) =>
                          element.courseName == uvm.selectedValues["Course"]))
                        for (var det in course.branches.where((element) =>
                            element['b'] == uvm.selectedValues["Branch"]))
                          for (var sub in det['sub']
                              ["${uvm.selectedValues["Semester"]}"])
                            sub
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2.8,
                ),
                DropDownMenu(
                  onChanged: (value) {
                    if (uvm.selectedValues["Type"] == "Notes") {
                      uvm.onChanged("College", value);
                    } else {
                      uvm.onChanged("Year", value);
                    }
                  },
                  customHeight: false,
                  hint: uvm.selectedValues["Type"] == "Notes"
                      ? "College"
                      : "Year",
                  value: uvm.selectedValues[
                      uvm.selectedValues["Type"] == "Notes"
                          ? "College"
                          : "Year"],
                  items: [
                    if (uvm.selectedValues["Subject"] != null)
                      if (uvm.selectedValues["Type"] == "Notes")
                        for (var course in uvm.courses.where((element) =>
                            element.courseName == uvm.selectedValues["Course"]))
                          for (var cl in course.colleges) cl,
                    if (uvm.selectedValues["Subject"] != null)
                      if (uvm.selectedValues["Type"] == "Question Papers")
                        for (var y in a) y
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2.8,
                ),
                Conditional.single(
                  context: context,
                  conditionBuilder: (c) =>
                      uvm.selectedValues["Type"] == "Question Papers",
                  widgetBuilder: (context) => Container(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeScaleTransition(
                          animation: animation,
                          child: child,
                        );
                      },
                      child: ConditionalSwitch.single(
                        context: context,
                        valueBuilder: (c) => uvm.selectedValues["Year"],
                        caseBuilders: {
                          "Multiple Years": (c) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropDownWidget(
                                  isYear: true,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 6.0,
                                      right: 4.0,
                                      top: 6.0,
                                      bottom: 6.0,
                                    ),
                                    child: picker.YearPicker(
                                      selectedDate: uvm.selectedValues["y1"] !=
                                              null
                                          ? DateTime(uvm.selectedValues["y1"])
                                          : null,
                                      firstDate: DateTime(2017),
                                      lastDate:
                                          DateTime(DateTime.now().year - 1),
                                      onChanged: (d) {
                                        uvm.onChanged("y1", d);
                                      },
                                    ),
                                  ),
                                ),
                                DropDownWidget(
                                  isYear: true,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 6.0,
                                        right: 4.0,
                                        top: 6.0,
                                        bottom: 6.0),
                                    child: picker.YearPicker(
                                      selectedDate: DateTime(
                                          uvm.selectedValues["y2"] ?? 2020),
                                      firstDate:
                                          uvm.selectedValues["y1"] != null
                                              ? DateTime(
                                                  uvm.selectedValues["y1"] + 1)
                                              : DateTime(2018),
                                      lastDate: DateTime(DateTime.now().year),
                                      onChanged: (d) {
                                        uvm.onChanged("y2", d);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          "Single Year": (c) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DropDownWidget(
                                  isYear: true,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 6.0,
                                        right: 4.0,
                                        top: 6.0,
                                        bottom: 6.0),
                                    child: picker.YearPicker(
                                      selectedDate: uvm.selectedValues["y3"] !=
                                              null
                                          ? DateTime(uvm.selectedValues["y3"])
                                          : null,
                                      firstDate: DateTime(2017),
                                      lastDate: DateTime(2020),
                                      onChanged: (d) {
                                        uvm.onChanged("y3", d);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                        fallbackBuilder: (c) => Container(),
                      ),
                    ),
                  ),
                  fallbackBuilder: (context) {
                    return Container(
                      width: SizeConfig.blockSizeHorizontal * 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0.5,
                            color: Colors.black,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text(
                                  "Units",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: RangeSlider(
                              max: 5,
                              min: 1,
                              divisions: 4,
                              onChanged: uvm.selectedValues["College"] != null
                                  ? (value) {
                                      uvm.onChanged("Range", value);
                                    }
                                  : null,
                              values: RangeValues(
                                  (uvm.selectedValues["min"] ?? 2).toDouble(),
                                  (uvm.selectedValues["max"] ?? 4).toDouble()),
                              labels: RangeLabels(
                                  "${uvm.selectedValues["min"] ?? 2}",
                                  "${uvm.selectedValues["max"] ?? 4}"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                InkWell(
                  onTap: (uvm.selectedValues["College"] != null) ||
                          (uvm.selectedValues["Year"] != null &&
                              (uvm.selectedValues["y1"] != null ||
                                  uvm.selectedValues["y3"] != null))
                      ? () => uvm.filePicker()
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0.5,
                          color: Colors.black,
                        )
                      ],
                    ),
                    height: SizeConfig.blockSizeVertical * 6.8,
                    width: SizeConfig.blockSizeHorizontal * 72,
                    child: uvm.file == null
                        ? Center(
                            child: Text(
                              "Select PDF",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 55,
                                child: Text(
                                  uvm.fileName ?? '',
                                  maxLines: 2,
                                ),
                              ),
                              Icon(
                                Icons.close,
                                color: Theme.of(context).accentIconTheme.color,
                              )
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
