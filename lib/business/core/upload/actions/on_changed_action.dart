import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/core/upload/models/upload_state.dart';

import '../../../main_state.dart';

class OnChangedAction extends ReduxAction<AppState> {
  final dynamic val;
  final dynamic key;

  static Map vals = {};

  OnChangedAction({this.val, this.key});

  @override
  void before() {
    vals = state.uploadState.selectedValues;
    if (val is RangeValues) {
      vals["min"] = (val.start).toInt();
      vals["max"] = (val.end).toInt();
    } else if (key == "Course") {
      vals["Branch"] = null;
      vals["Semester"] = null;
      vals["Subject"] = null;
      vals["College"] = null;
      vals["$key"] = val;
    } else if (key == "y1") {
      if (vals["y2"] == val) {
        vals["y2"] = 2020;
      }
      vals["$key"] = val;
    } else {
      vals["$key"] = val;
    }
    print(vals);
  }

  @override
  AppState reduce() {
    return state.copy(
      uploadState: UploadState(
        fileName: state.uploadState.fileName,
        file: state.uploadState.file,
        selectedValues: vals,
        selectedVal: val,
        index: state.uploadState.index,
      ),
    );
  }
}
