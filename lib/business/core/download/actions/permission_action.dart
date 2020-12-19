import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../main_state.dart';

class PermissionAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      await Permission.storage.request();
    } else if (status.isDenied) {
      await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      //show snackbar
    } else if (status.isGranted) {
      Directory('/storage/emulated/0/Papersy/').create();
      // dispatch(FetchFilesAction());
    }
    return null;
  }
}