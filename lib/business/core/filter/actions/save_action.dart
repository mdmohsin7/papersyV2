import 'package:async_redux/async_redux.dart';
import 'package:async_redux/local_persist.dart';
import 'package:papersy/business/core/filter/actions/subscribe_action.dart';
import 'package:papersy/business/core/home/actions/home_action.dart';
import 'package:papersy/client/models/filter_model.dart';

import '../../../main_state.dart';

class SaveAction extends ReduxAction<AppState> {
  static dynamic val;

  @override
  void before() {
    val = state.filterState.selectedVal;
    state.filterState.selectedVals[2] = val;
    var branch = state.filterState.selectedVals[1];
    var sem = state.filterState.selectedVals[2];
    if (state.filterState.getNotified) {
      dispatch(SubscribeAction(branch: branch, sem: sem));
    }
  }

  @override
  Future<AppState> reduce() async {
    var persist = LocalPersist("settings");
    FiltersModel fm = FiltersModel(
        branch: state.filterState.selectedVals[1],
        course: state.filterState.selectedVals[0],
        semester: state.filterState.selectedVals[2]);
    List<Object> list = [
      fm.toJosn(),
    ];
    await persist.save(list);
    dispatch(HomeAction(0));
    return null;
  }
}
