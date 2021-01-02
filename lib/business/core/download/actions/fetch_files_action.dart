import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:filex/filex.dart';
import 'package:papersy/business/core/download/actions/permission_action.dart';
import 'package:papersy/business/core/download/models/download_state.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../main_state.dart';

class FetchFilesAction extends ReduxAction<AppState> {
  static StreamSubscription<List<DirectoryItem>> _sub;
  @override
  void before() => dispatch(PermissionAction());

  @override
  Future<AppState> reduce() async {
    final controller = FilexController(path: '/storage/emulated/0/Papersy/');
    _sub = controller.changefeed.listen((items) {
      dispatch(PassFilesAction(files: items));
    });
    return null;
  }

  @override
  Object wrapError(error) => UserException(error.toString(), cause: error);
}

class PassFilesAction extends ReduxAction<AppState> {
  final List<DirectoryItem> files;

  PassFilesAction({this.files});
  @override
  AppState reduce() {
    return state.copy(
      downloadState: DownloadState(
        files: files,
        permissionStatus: true,
      ),
    );
  }
}

void fetchFiles(Store store) {
  store.dispatch(FetchFilesAction());
}

class DAction extends ReduxAction<AppState> {
  @override
  FutureOr<void> before() {
    dispatch(PermissionAction());
  }

  @override
  Future<AppState> reduce() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      dispatch(NavigateAction.pushNamed("downloads"));
    }
    return null;
  }
}
