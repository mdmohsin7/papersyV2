import 'package:animations/animations.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/core/upload/actions/dispose_action.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/sizeconfig.dart';
import '.././upload/upload_connector.dart';
import '.././upload/widgets/initial_form_widget.dart';
import '.././upload/widgets/second_form_widget.dart';

class UploadWidget extends StatelessWidget {
  const UploadWidget();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _width = SizeConfig.blockSizeHorizontal;
    double _height = SizeConfig.blockSizeVertical;
    return StoreConnector<AppState, UVM>(
      // onInit: (state) => initFilterAction(state),
      onDispose: (state) => dispose(state),
      vm: UploadVM(),
      builder: (context, uvm) {
        return WillPopScope(
          onWillPop: () {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).backgroundColor,
                    title: const Text(
                        "Are you sure you want to leave this screen?"),
                    content: const Text("The changes you made will be lost."),
                    actions: [
                      RaisedButton(
                        elevation: 0.0,
                        color: Theme.of(context).backgroundColor,
                        onPressed: () {
                          Navigator.of(context)..pop()..pop();
                        },
                        child: Text(
                          "Confirm",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      )
                    ],
                  );
                });
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 12,
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    transitionBuilder: (child, an) {
                      return FadeScaleTransition(
                        child: child,
                        animation: an,
                      );
                    },
                    child: PageTransitionSwitcher(
                      reverse: true,
                      transitionBuilder: (child, primaryA, secondaryA) {
                        return SharedAxisTransition(
                          fillColor: Theme.of(context).backgroundColor,
                          transitionType: SharedAxisTransitionType.horizontal,
                          animation: primaryA,
                          secondaryAnimation: secondaryA,
                          child: child,
                        );
                      },
                      child: uvm.index == 0
                          ? const InitialFormWidget()
                          : const SecondFormWidget(),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          textColor: Theme.of(context).primaryColor,
                          elevation: 0.0,
                          color: Theme.of(context).backgroundColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(uvm.index == 0 ? "Cancel" : "Back"),
                          onPressed: () {
                            if (uvm.index == 0) {
                              Navigator.pop(context);
                            } else if (!uvm.isUploading) {
                              uvm.updateIndex(true);
                            } else {
                              null;
                            }
                          },
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (c) => uvm.index == 0,
                          widgetBuilder: (c) => RaisedButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .color),
                            ),
                            onPressed: uvm.selectedValues["Uploader"] != null &&
                                    uvm.selectedValues["Uploader"] != '' &&
                                    uvm.selectedValues["Uploader"].length > 3 &&
                                    uvm.selectedValues["Semester"] != null &&
                                    uvm.selectedValues["Branch"] != null
                                ? () => uvm.updateIndex(false)
                                : null,
                          ),
                          fallbackBuilder: (c) => RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              "Upload",
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline5.color,
                              ),
                            ),
                            onPressed: (uvm.file != null ||
                                        (uvm.selectedValues["Link"] != null &&
                                            uvm.selectedValues["Link"] !=
                                                '')) &&
                                    !uvm.isUploading
                                ? () async {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return WillPopScope(
                                          onWillPop: () async => false,
                                          child: AlertDialog(
                                            backgroundColor: Theme.of(context)
                                                .backgroundColor,
                                            title: Center(
                                              child: Text("Uploading"),
                                            ),
                                            content: Container(
                                              height: _height * 10,
                                              width: _width * 10,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(Values
                                                          .uploadingFiles)),
                                                  const LinearProgressIndicator()
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    uvm.startUploading();
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
