import 'package:async_redux/async_redux.dart';
import 'package:filex/filex.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/client/screens/downloads/downloads_connector.dart';

import '../../../sizeconfig.dart';

class DownloadsWidget extends StatelessWidget {
  const DownloadsWidget();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final controller = FilexController(path: "/storage/emulated/0/Papersy/");
    return StoreConnector<AppState, DVM>(
      vm: DownloadsVM(),
      // onInit: (store) => fetchFiles(store),
      builder: (context, dvm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Downloads"),
          ),
          body: Filex(
            controller: controller,
            actions: const <PredefinedAction>[PredefinedAction.delete],
          ),
        );
      },
    );
  }
}
