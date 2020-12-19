import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/upload/models/upload_state.dart';

import '../../../main_state.dart';

void dispose(Store<AppState> state) {
  return state.dispatch(DisposeAction());
}

class DisposeAction extends ReduxAction<AppState> {
  static Map test = {};

  @override
  void before() {
    test = state.uploadState.selectedValues;
    test.clear();
    dispatch(WaitAction.clear());
  }

  @override
  AppState reduce() {
    return state.copy(
      uploadState: UploadState(
        fileName: '',
        file: null,
        selectedVal: null,
        selectedValues: test,
        index: 0,
      ),
    );
  }
}
