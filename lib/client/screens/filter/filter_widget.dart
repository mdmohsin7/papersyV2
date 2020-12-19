import 'package:animations/animations.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/core/filter/actions/filter_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/filter/filter_union.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/screens/filter/filter_connector.dart';
import 'package:papersy/client/widgets/drop_down_menu.dart';
import 'package:papersy/sizeconfig.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StoreConnector<AppState, FVM>(
      onInit: (state) => initFilterAction(state),
      onDispose: (state) => disposeFilterAction(state),
      vm: FilterVM(),
      builder: (context, fvm) {
        List<Widget> dropDownMenu = [
          DropDownMenu(
            customHeight: false,
            onChanged: (String val) => fvm.onChange(val),
            items: [
              for (var course in fvm.coursesList) course.courseName,
            ],
            value: fvm.selectedValue,
            hint: "Course",
          ),
          DropDownMenu(
            customHeight: false,
            onChanged: (String val) => fvm.onChange(val),
            items: [
              if (fvm.selectedVals != null)
                if (fvm.selectedVals.length < 0) "",
              if (fvm.selectedVals != null)
                if (fvm.selectedVals.length > 0)
                  for (var doc in fvm.coursesList.where(
                      (element) => element.courseName == fvm.selectedVals[0]))
                    for (var branch in doc.branches) branch['b'],
            ],
            value: fvm.selectedValue,
            hint: "Branch",
          ),
          DropDownMenu(
            customHeight: false,
            onChanged: (String val) => fvm.onChange(val),
            items: [
              if (fvm.selectedVals != null)
                if (fvm.selectedVals.length > 0)
                  if (fvm.coursesList
                      .where((element) =>
                          element.courseName == fvm.selectedVals[0])
                      .isNotEmpty)
                    for (var item in fvm.coursesList.where(
                        (element) => element.courseName == fvm.selectedVals[0]))
                      if (item != null)
                        for (var semester in item.semesters)
                          (semester).toString(),
              if (fvm.selectedVals != null)
                if (fvm.selectedVals.length < 0) "",
            ],
            value: fvm.selectedValue,
            hint: "Semester",
          ),
        ];
        return Container(
          height: SizeConfig.blockSizeVertical * 56,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Builder(
            builder: (context) {
              if (fvm.filterUnion is Loading) {
                return Center(
                  child: Text("loading"),
                );
              } else if (fvm.filterUnion is NoInternet) {
                return Center(
                  child: Text(Values.noInternet),
                );
              } else if (fvm.filterUnion is Loaded) {
                return Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 6,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 82,
                      child: Center(
                        child: Text(
                          Values.filterHint,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2.6,
                    ),
                    PageTransitionSwitcher(
                      transitionBuilder: (child, primaryA, secondaryA) {
                        return SharedAxisTransition(
                            child: child,
                            animation: primaryA,
                            secondaryAnimation: secondaryA,
                            transitionType: SharedAxisTransitionType.scaled);
                      },
                      child: dropDownMenu[fvm.index],
                    ),
                    Spacer(flex: 3,),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 85,
                      child: Row(
                        children: [
                          Checkbox(
                            tristate: false,
                            value: fvm.getNotified,
                            onChanged: (value) {
                              fvm.updateCheckbox(value);
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 65,
                            child: Text(
                              "Get notified when new notes/papers are added to this branch",
                              textAlign: TextAlign.left,
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(flex: 1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          elevation: 0.0,
                          color: Theme.of(context).backgroundColor,
                          textColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: fvm.index == 0 ? Text("Cancel") : Text("Back"),
                          onPressed: fvm.index == 0
                              ? () => Navigator.pop(context)
                              : () => fvm.update(true),
                        ),
                        RaisedButton(
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: fvm.index == 2 ? Text("Save") : Text("Next"),
                          onPressed: fvm.selectedValue != null && fvm.index < 2
                              ? () => fvm.update(false)
                              : fvm.selectedValue != null && fvm.index == 2
                                  ? () {
                                      fvm.save();
                                      Navigator.pop(context);
                                    }
                                  : null,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              } else {
                print(fvm.filterUnion);
                return Container(
                  child: Center(
                    child: Text(
                        "Oops! Something went wrong. Please try again later"),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
