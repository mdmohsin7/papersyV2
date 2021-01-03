import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:async_redux/local_persist.dart';
import 'package:papersy/business/core/theme/actions/change_theme_action.dart';
import 'package:papersy/business/main_state.dart';

class CheckThemeAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    if (await LocalPersist('theme').exists()) {
      var isDark = await LocalPersist('theme').load();
      Map a = isDark[0];
      dispatch(ChangeThemeAction(a['isDark']));
    }
    return null;
  }
}

void checkTheme(Store<AppState> store) {
  store.dispatch(CheckThemeAction());
}
