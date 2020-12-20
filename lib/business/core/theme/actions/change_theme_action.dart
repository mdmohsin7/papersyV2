import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/theme/models/theme_state.dart';

import '../../../main_state.dart';

class ChangeThemeAction extends ReduxAction<AppState> {
  final bool isDark;

  ChangeThemeAction(this.isDark);
  @override
  AppState reduce() {
    return state.copy(themeState: ThemeState(isDark: isDark));
  }
}