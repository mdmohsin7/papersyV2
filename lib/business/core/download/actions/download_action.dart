import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:async_redux/async_redux.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:papersy/business/core/download/actions/permission_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/values.dart';

class DownloadAction extends ReduxAction<AppState> {
  String subject;
  String college;
  String link;
  DownloadAction({this.subject, this.college, this.link});

  @override
  Future<void> before() async {
    dispatch(PermissionAction());
    var sub = await Connectivity().checkConnectivity();
    if (sub == ConnectivityResult.none) {
      throw UserException(
        Values.noInternet,
      );
    }
  }

  @override
  Future<AppState> reduce() async {
    var filename = "${subject}_${college}_papersy_" +
        math.Random().nextInt(2020).toString() +
        ".pdf";
    var _dir = Directory("/storage/emulated/0/Papersy/");
    var dlink;
    print(link);
    if (link.contains("http")) {
      dlink = link;
    } else {
      dlink = "https://drive.google.com/uc?export=download&id=" + link;
    }
    if (_dir.existsSync()) {
      await FlutterDownloader.enqueue(
        url: dlink,
        savedDir: "/storage/emulated/0/Papersy/",
        openFileFromNotification: true,
        showNotification: true,
        fileName: filename,
      );
      return null;
    } else {
      return null;
    }
  }

  @override
  Object wrapError(error) {
    return UserException(error.toString(), cause: error);
  }
}
