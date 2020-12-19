
import 'package:async_redux/async_redux.dart';
import 'package:open_file/open_file.dart';

import '../../../main_state.dart';

class OpenFileAction extends ReduxAction<AppState> {
  final String filePath;
  OpenFileAction({this.filePath});

  @override
  Future<AppState> reduce() async {
    print("open");
    // File file = File(filePath);
    await OpenFile.open(filePath);
    // PDFDocument doc = await PDFDocument.fromFile(file);
    // if (doc != null) {
    //   dispatch(NavigateAction.pushNamed("pdf_viewer", arguments: doc));
    // }
    return null;
  }
}
