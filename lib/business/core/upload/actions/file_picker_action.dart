import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:file_picker/file_picker.dart';
import 'package:papersy/business/core/upload/models/upload_state.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../main_state.dart';

class FilePickerAction extends ReduxAction<AppState> {
  static File file;
  static PlatformFile f;
  static String name;

  @override
  Future<Future<void>> before() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      await Permission.storage.request();
    } else if (status.isDenied) {
      await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      //show snackbar

    }
    return null;
  }

  @override
  Future<AppState> reduce() async {
    if (await Permission.storage.isGranted) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: false);
      if (result != null) {
        file = File(result.files.single.path);
        file.stat().then((value) => value.size);
        f = result.files.first;
        name = f.name;
      }

      return state.copy(
        uploadState: UploadState(
          file: file,
          fileName: name,
          index: state.uploadState.index,
          selectedVal: state.uploadState.selectedVal,
          selectedValues: state.uploadState.selectedValues,
        ),
      );
    } else {
      return null;
    }
  }
}
