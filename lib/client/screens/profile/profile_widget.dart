import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/validators.dart';
import 'package:papersy/client/screens/profile/profile_connector.dart';
import 'package:papersy/client/widgets/text_form_field.dart';
import 'package:papersy/client/widgets/update_widget.dart';

import '../../../sizeconfig.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    return StoreConnector<AppState, PVM>(
      vm: () => ProfileVM(),
      builder: (context, pvm) {
        print(pvm.isUpdating);
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            centerTitle: true,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RepaintBoundary(
                  child: Container(
                    height: _height * 25,
                    width: _width * 40,
                    child: SvgPicture.asset("assets/profile.svg"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: _height * 3.5, right: _height * 3.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: CustomTextField(
                    hint: pvm.email,
                    icon: Icons.email,
                    isEnabled: false,
                    isObscure: false,
                    validator: (e) => validateEmail(e),
                  ),
                ),
                SizedBox(
                  height: _height * 4,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_height * 1.3)),
                  child: Text(
                    "Update Email",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline5.color),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (c) => UpdateWidget(
                          title: "Update Email",
                          onSubmit: (e, o) => pvm.updateEmail(e, o),
                          isUpdating: pvm.isUpdating,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: _height * 1.5,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_height * 1.3)),
                  child: Text(
                    "Update Password",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline5.color),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (c) => UpdateWidget(
                          title: "Update Password",
                          onSubmit: (a, b) => pvm.updatePassword(a, b),
                          isUpdating: pvm.isUpdating,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
