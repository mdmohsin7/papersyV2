import 'package:async_redux/async_redux.dart';
import 'package:filex/filex.dart';
import 'package:papersy/business/core/download/actions/fetch_files_action.dart';
import 'package:papersy/business/core/download/actions/open_file_action.dart';
import 'package:papersy/business/core/download/actions/permission_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/client/screens/downloads/downloads_widget.dart';

class DownloadsVM extends VmFactory<AppState, DownloadsWidget> {
  DownloadsVM() : super();

  @override
  DVM fromStore() {
    return DVM(
      fetchFiles: () => dispatch(FetchFilesAction()),
      files: state.downloadState.files,
      openFile: (filePath) => dispatch(OpenFileAction(filePath: filePath)),
      requestPermission: () => dispatch(PermissionAction()),
      isPermissionGranted: state.downloadState.permissionStatus,
    );
  }
}

class DVM extends Vm {
  final List<DirectoryItem> files;
  final Function(String) openFile;
  final Function fetchFiles;
  final Function requestPermission;
  final bool isPermissionGranted;

  DVM(
      {this.files,
      this.openFile,
      this.fetchFiles,
      this.requestPermission,
      this.isPermissionGranted})
      : super(equals: [files, isPermissionGranted]);
}
