import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/core/preview/actions/preview_action.dart';
import 'package:papersy/client/screens/preview/preview_connector.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewWidget extends StatelessWidget {
  final String url;
  const PreviewWidget({this.url});
  @override
  Widget build(BuildContext context) {
    var urls = Uri.encodeComponent(url);
    print("test: ${Uri.encodeComponent(url)}");
    return StoreConnector<AppState, PreVM>(
      onDispose: (store) => previewDispose(store),
      vm: PreviewVM(),
      builder: (context, prevm) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Preview'),
          ),
          body: IndexedStack(
            index: prevm.index,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (s) {
                  prevm.switchIndex(0);
                },
                onPageFinished: (s) {
                  prevm.switchIndex(1);
                },
                navigationDelegate: (navigationRequest) {
                  return NavigationDecision.prevent;
                },
                initialUrl: url.toString().contains("drive")
                    ? url.toString()
                    : "https://docs.google.com/gview?embedded=true&url=" + urls,
              ),
            ],
          ),
        );
      },
    );
  }
}
