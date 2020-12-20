import 'package:async_redux/async_redux.dart';
import 'package:async_redux/local_persist.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/core/theme/models/theme_state.dart';

class ThemeAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    var val = state.themeState.isDark;
    if (val) {
      return state.copy(themeState: ThemeState(isDark: false));
    } else {
      return state.copy(themeState: ThemeState(isDark: true));
    }
  }

  @override
  void after() {
    var persist = LocalPersist("theme");
    persist.save([state.themeState.toJson()]);
  }
}


