import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadState extends Equatable {
  final File file;
  final Map<dynamic, dynamic> selectedValues;
  final dynamic selectedVal;
  final int index;
  final String fileName;

  UploadState(
      {this.file,
      this.selectedValues,
      this.selectedVal,
      this.index,
      this.fileName});

  UploadState copy(
      {File file,
      Map<dynamic, dynamic> selectedValues,
      dynamic selectedVal,
      int index,
      String fileName}) {
    return UploadState(
        fileName: fileName ?? this.fileName,
        selectedVal: selectedVal ?? this.selectedVal,
        file: file ?? this.file,
        selectedValues: selectedValues ?? this.selectedValues,
        index: index ?? this.index);
  }

  static initialState() => UploadState(
      file: null,
      selectedValues: {},
      selectedVal: null,
      index: 0,
      fileName: '');

  @override
  List<Object> get props => [file, selectedValues, index,fileName,selectedVal];
}
