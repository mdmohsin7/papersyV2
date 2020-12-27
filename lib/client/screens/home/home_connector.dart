import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:papersy/business/core/auth/actions/logout_action.dart';
import 'package:papersy/business/core/theme/actions/theme_action.dart';
import 'package:papersy/business/main_state.dart';
import 'home_widget.dart';
import '../../../business/core/download/actions/fetch_files_action.dart';

class HomeVM extends VmFactory<AppState, Home> {
  HomeVM() : super();
  @override
  HVM fromStore() {
    return HVM(
      drawerIndex: state.homeState.index,
      navigate: (route) =>  route == "downloads" ? dispatch(DAction()) :  dispatch(NavigateAction.pushNamed("$route")),
      authStatus: state.authState.user,
      switchTheme: () => dispatch(ThemeAction()),
      logOut: () => dispatch(LogOutAction()),
    );
  }
}

class HVM extends Vm {
  final int drawerIndex;
  final Function(String) navigate;
  final User authStatus;
  final Function switchTheme;
  final Function logOut;

  HVM({
    this.logOut,
    this.navigate,
    this.drawerIndex,
    this.authStatus,
    this.switchTheme,
  }) : super(equals: [
          drawerIndex,
          authStatus,
        ]);
}
