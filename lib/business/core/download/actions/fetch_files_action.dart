import 'dart:async';
import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/download/actions/permission_action.dart';
import 'package:papersy/business/core/download/models/download_state.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../main_state.dart';

class FetchFilesAction extends ReduxAction<AppState> {
  @override
  void before() => dispatch(PermissionAction());

  @override
  Future<AppState> reduce() async {
    var _dir =  Directory('/storage/emulated/0/Papersy/');
    List<FileSystemEntity> _files2;
    try {
      _files2 =  _dir.listSync(recursive: true, followLinks: false);
      dispatch(PassFilesAction(files: _files2));
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Object wrapError(error) => UserException(error.toString(), cause: error);
}

class PassFilesAction extends ReduxAction<AppState> {
  final List<FileSystemEntity> files;

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

class DAction extends ReduxAction<AppState>{
  @override
  FutureOr<void> before() {
    dispatch(PermissionAction());
  }
  @override
  Future<AppState> reduce() async{
    var status = await Permission.storage.status;
    if(status.isGranted){
      dispatch(NavigateAction.pushNamed("downloads"));
    }
    return null;
  }
}