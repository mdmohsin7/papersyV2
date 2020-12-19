import 'package:async_redux/async_redux.dart';

import '../models/filter_state.dart';
import '../../../main_state.dart';
import '../../../unions/filter/filter_union.dart';

import 'fetch_courses_action.dart';

class DropDownAction extends ReduxAction<AppState> {
  final dynamic value;

  DropDownAction(this.value);

  @override
  AppState reduce() {
    return state.copy(
      filterState: FilterState(
        selectedVals: state.filterState.selectedVals,
        selectedVal: value,
        courses: state.filterState.courses,
        index: state.filterState.index,
        filterUnion: state.filterState.filterUnion,
        getNotified: state.filterState.getNotified,
      ),
    );
  }
}

class IndexAction extends ReduxAction<AppState> {
  final bool isBack;

  static Map vals = {};
  static int index;
  static dynamic sv;

  IndexAction(this.isBack);

  @override
  void before() {
    if (!isBack) {
      vals[state.filterState.index] = state.filterState.selectedVal;
    }
    if (isBack) {
      index = state.filterState.index - 1;
      sv = state.filterState.selectedVals[index];
    }
  }

  @override
  AppState reduce() {
    print(state.filterState.selectedVals);
    return state.copy(
      filterState: FilterState(
        selectedVals: isBack ? state.filterState.selectedVals : vals,
        courses: state.filterState.courses,
        selectedVal: isBack ? state.filterState.selectedVals[index] : null,
        index: isBack ? index : (state.filterState.index) + 1,
        filterUnion: state.filterState.filterUnion,
        getNotified: state.filterState.getNotified,
      ),
    );
  }
}

class DisposeAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copy(
      filterState: FilterState(
        courses: state.filterState.courses,
        index: 0,
        selectedVal: null,
        selectedVals: {},
        filterUnion: FilterUnion.none(),
        getNotified: state.filterState.getNotified,
      ),
    );
  }
}

void initFilterAction(Store<AppState> state) {
  return state.dispatch(FetchCoursesAction());
}

void disposeFilterAction(Store<AppState> state) {
  return state.dispatch(DisposeAction());
}
