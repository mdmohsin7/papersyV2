import 'package:async_redux/async_redux.dart';
import 'package:connectivity/connectivity.dart';
import 'package:papersy/business/main_state.dart';

class PreviewAction extends ReduxAction<AppState> {
  String url;
  PreviewAction({this.url});

  @override
  Future<void> before() async {
    var sub = await Connectivity().checkConnectivity();
    if (sub == ConnectivityResult.none) {
      throw UserException(
        "Please check your internet connection and then try again",
      );
    }
  }

  @override
  AppState reduce() {
    dispatch(
      NavigateAction.pushNamed('preview', arguments: url),
    );
    return null;
  }
}
