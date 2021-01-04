import 'package:async_redux/async_redux.dart';
import 'package:connectivity/connectivity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewAction extends ReduxAction<AppState> {
  String url;
  bool isTutorial;
  PreviewAction({@required this.url, this.isTutorial = false});

  @override
  Future<void> before() async {
    var sub = await Connectivity().checkConnectivity();
    if (sub == ConnectivityResult.none) {
      throw UserException(Values.noInternet);
    }
  }

  @override
  Future<AppState> reduce() async {
    if (isTutorial) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw UserException("Could not launch $url",
            cause: "Something went wrong!");
      }
    } else {
      dispatch(
        NavigateAction.pushNamed('preview', arguments: url),
      );
    }
    return null;
  }
}
