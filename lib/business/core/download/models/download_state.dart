import 'dart:io';

import 'package:equatable/equatable.dart';

class DownloadState extends Equatable{
  final List<FileSystemEntity> files;
  final bool permissionStatus;

  DownloadState({this.files, this.permissionStatus});

 DownloadState copy({List<FileSystemEntity> files, bool permissionStatus}) {
    return DownloadState(
      files: files ?? this.files,
      permissionStatus: permissionStatus ?? this.permissionStatus,
    );
  }

  static DownloadState initialState() => DownloadState(files: null,permissionStatus: false);

  @override
  List<Object> get props => [files,permissionStatus];
}
