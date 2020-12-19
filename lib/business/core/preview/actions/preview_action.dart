import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/core/preview/models/preview_state.dart';

class PreviewAction extends ReduxAction<AppState> {
  final int index;

  PreviewAction({this.index});
  @override
  AppState reduce() {
    return state.copy(
      previewState: PreviewState(index: index),
    );
  }
}

class DisposeAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copy(
      previewState: PreviewState(index: 0),
    );
  }
}

void previewDispose(Store<AppState> store) {
  return store.dispatch(DisposeAction());
}
