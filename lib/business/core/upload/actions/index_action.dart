
import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/upload/models/upload_state.dart';

import '../../../main_state.dart';

class IndexAction extends ReduxAction<AppState> {
  final bool isBack;
  IndexAction(this.isBack);

  @override
  AppState reduce() {
    if (isBack) {
      return state.copy(
        uploadState: UploadState(
          fileName: state.uploadState.fileName,
          index: state.uploadState.index - 1,
          file: state.uploadState.file,
          selectedVal: state.uploadState.selectedVal,
          selectedValues: state.uploadState.selectedValues,
        ),
      );
    } else {
      return state.copy(
        uploadState: UploadState(
          fileName: state.uploadState.fileName,
          index: state.uploadState.index + 1,
          file: state.uploadState.file,
          selectedVal: state.uploadState.selectedVal,
          selectedValues: state.uploadState.selectedValues,
        ),
      );
    }
  }
}