import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/core/upload/actions/file_picker_action.dart';
import 'package:papersy/business/core/upload/actions/on_changed_action.dart';
import 'package:papersy/business/core/upload/actions/upload_action.dart';
import 'package:papersy/client/models/course_model.dart';
import 'package:papersy/client/screens/upload/upload_widget.dart';

class UploadVM extends VmFactory<AppState, UploadWidget> {
  UploadVM() : super();

  @override
  UVM fromStore() {
    return UVM(
      isUploading: state.wait.isWaitingFor("uploading"),
      updateIndex: (bool) => dispatch(IndexAction(bool)),
      index: state.uploadState.index,
      selectedVal: state.uploadState.selectedVal,
      selectedValues: state.uploadState.selectedValues,
      courses: state.filterState.courses,
      onChanged: (k, v) => dispatch(OnChangedAction(key: k, val: v)),
      filePicker: () => dispatch(FilePickerAction()),
      startUploading: () => dispatch(UploadAction()),
      fileName: state.uploadState.fileName,
      file: state.uploadState.file,
    );
  }
}

class UVM extends Vm {
  final int index;
  final List<CourseModel> courses;
  final Function(dynamic, dynamic) onChanged;
  final dynamic selectedVal;
  final Map<dynamic, dynamic> selectedValues;
  final Function(bool) updateIndex;
  final Function filePicker;
  final String fileName;
  final File file;
  final Function startUploading;
  final bool isUploading;

  UVM(
      {this.index,
      this.fileName,
      this.courses,
      this.onChanged,
      this.selectedVal,
      this.selectedValues,
      this.updateIndex,
      this.filePicker,
      this.file,
      this.startUploading,
      this.isUploading})
      : super(equals: [
          index,
          file,
          fileName,
          courses,
          selectedVal,
          selectedValues,
          isUploading
        ]);
}
