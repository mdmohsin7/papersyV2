import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_svg/svg.dart';
import 'package:papersy/business/core/download/actions/fetch_files_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/screens/downloads/downloads_connector.dart';

import '../../../sizeconfig.dart';

class DownloadsWidget extends StatefulWidget {
  const DownloadsWidget();

  @override
  _DownloadsWidgetState createState() => _DownloadsWidgetState();
}

class _DownloadsWidgetState extends State<DownloadsWidget> {
  List<FileSystemEntity> _files;

  @override
  void initState() {
    super.initState();
    var dir = Directory('/storage/emulated/0/Papersy/');
    _files = dir.listSync(recursive: true, followLinks: false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    return StoreConnector<AppState, DVM>(
      vm: DownloadsVM(),
      // onInit: (store) => fetchFiles(store),
      builder: (context, dvm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Downloads"),
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (c) => _files != null,
            widgetBuilder: (c) => ListView.separated(
              separatorBuilder: (context, i) => const Divider(),
              itemCount: _files.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    leading: const Icon(Icons.picture_as_pdf_rounded),
                    title: Text(
                      _files
                          .elementAt(index)
                          .path
                          .split('/')
                          .last
                          .toString(),
                      maxLines: 2,
                    ),
                    onTap: () {
                      String fp = _files.elementAt(index).path;
                      dvm.openFile(fp);
                    },
                  ),
                );
              },
            ),
            fallbackBuilder: (c) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ((_files == null) || _files.length < 1) &&
                            dvm.isPermissionGranted
                        ? Column(
                            children: [
                              Container(
                                  height: _height * 37,
                                  width: _width * 42,
                                  child: SvgPicture.asset("assets/empty.svg")),
                              Text(Values.notDownloaded),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              Values.noPermission,
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                  (_files == null || _files.length < 1) &&
                          dvm.isPermissionGranted
                      ? RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Download Now",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline5.color,
                            ),
                          ),
                        )
                      : RaisedButton(
                          onPressed: dvm.requestPermission,
                          child: Text(
                            "Request Permission",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline5.color,
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
