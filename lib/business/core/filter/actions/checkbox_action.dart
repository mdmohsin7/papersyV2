import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/filter/models/filter_state.dart';
import 'package:papersy/business/main_state.dart';

class CheckBoxAction extends ReduxAction<AppState> {
  final bool value;

  CheckBoxAction({this.value});

  @override
  AppState reduce() {
    return state.copy(
      filterState: FilterState(
        courses: state.filterState.courses,
        filterUnion: state.filterState.filterUnion,
        getNotified: value,
        index: state.filterState.index,
        selectedVal: state.filterState.selectedVal,
        selectedVals: state.filterState.selectedVals,
      ),
    );
  }
}
