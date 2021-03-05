import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/sizeconfig.dart';

import 'auth_connector.dart';
import 'login/login_widget.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    return StoreConnector<AppState, AVM>(
      vm: () => AuthVM(),
      builder: (context, avm) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: ListView(
            padding: EdgeInsets.all(_height * 9),
            children: [
              RepaintBoundary(
                child: Container(
                  height: _height * 50,
                  width: _width * 60,
                  child: SvgPicture.asset("assets/account.svg"),
                ),
              ),
              SignInButton(
                Buttons.Email,
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (c) => LoginWidget()));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("Or"),
                  ),
                ],
              ),
              SignInButton(
                Buttons.GoogleDark,
                onPressed: () {
                  avm.signIn();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
