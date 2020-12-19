import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/main.dart';


class ThemeVM extends VmFactory<AppState, MyApp>{
  @override
  TVM fromStore() {
    return TVM(isDark: state.themeState.isDark );
  }
}


class TVM extends Vm{
  final bool isDark;

  TVM({this.isDark}):super(equals: [isDark]);
}