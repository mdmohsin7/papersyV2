import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/screens/upload/upload_connector.dart';
import 'package:papersy/client/widgets/drop_down_menu.dart';
import 'package:papersy/client/widgets/drop_down_widget.dart';

import '../../../../sizeconfig.dart';

class InitialFormWidget extends StatelessWidget {
  const InitialFormWidget();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StoreConnector<AppState, UVM>(
      vm: UploadVM(),
      builder: (context, uvm) {
        return Container(
          height: SizeConfig.blockSizeVertical * 76,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  Values.initialForm,
                  textAlign: TextAlign.center,
                ),
              ),
              DropDownMenu(
                items: [
                  "Notes",
                  "Question Papers",
                ],
                value: uvm.selectedValues["Type"],
                onChanged: (value) => uvm.onChanged("Type", value),
                hint: "Type",
                customHeight: false,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.8,
              ),
              DropDownMenu(
                items: [
                  if (uvm.selectedValues["Type"] != null)
                    for (var course in uvm.courses) course.courseName
                ],
                value: uvm.selectedValues["Course"],
                onChanged: (value) => uvm.onChanged("Course", value),
                hint: "Course",
                customHeight: false,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.8,
              ),
              DropDownMenu(
                items: [
                  if (uvm.courses != null)
                    for (var course in uvm.courses.where((element) =>
                        element.courseName == uvm.selectedValues["Course"]))
                      for (var branch in course.branches) branch['b']
                ],
                value: uvm.selectedValues["Branch"],
                onChanged: (value) => uvm.onChanged("Branch", value),
                hint: "Branch",
                customHeight: false,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.8,
              ),
              DropDownMenu(
                items: [
                  if (uvm.selectedValues["Branch"] != null)
                    for (var course in uvm.courses.where((element) =>
                        element.courseName == uvm.selectedValues["Course"]))
                      for (var semester in course.semesters) semester.toString()
                ],
                value: uvm.selectedValues["Semester"],
                onChanged: (value) => uvm.onChanged("Semester", value),
                hint: "Semester",
                customHeight: false,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.8,
              ),
              DropDownWidget(
                isYear: false,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Form(
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: uvm.selectedValues["Uploader"] ?? null,
                      onChanged: (value) => uvm.onChanged("Uploader", value),
                      onFieldSubmitted: (value) =>
                          uvm.onChanged("Uploader", value),
                      validator: (value) {
                        if (value.length < 3) {
                          return "atleast 3 characters long";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 10.0, bottom: 2.0),
                        border: InputBorder.none,
                        hintText: "Uploader",
                      ),
                      enabled:
                          uvm.selectedValues["Semester"] != null ? true : false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
