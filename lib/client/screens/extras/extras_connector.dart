import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/download/actions/download_action.dart';
import 'package:papersy/business/core/download/actions/preview_action.dart';
import 'package:papersy/business/core/user_activity/actions/report_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/extras/extras_union.dart';
import 'package:papersy/client/models/extra_model.dart';
import 'package:papersy/client/screens/extras/extras_widget.dart';

class ExtrasVM extends VmFactory<AppState, ExtrasWidget> {
  @override
  EVM fromStore() {
    return EVM(
      extrasList: state.homeState.extras,
      extrasUnion: state.homeState.extrasUnion,
      download: (sub, year, link) => dispatch(
        DownloadAction(
          subject: sub,
          college: year,
          link: link,
        ),
      ),
      preview: (url, isTutorial) =>
          dispatch(PreviewAction(url: url, isTutorial: isTutorial)),
      report: (type, course, sem, branch) => dispatch(
        ReportAction(type: type, course: course, sem: sem, branch: branch),
      ),
    );
  }
}

class EVM extends Vm {
  final List<Extra> extrasList;
  final Function(String, bool) preview;
  final Function(String, String, String) download;
  final Function(String, String, String, String) report;
  final ExtrasUnion extrasUnion;

  EVM(
      {this.extrasList,
      this.preview,
      this.download,
      this.report,
      this.extrasUnion})
      : super(equals: [extrasList, extrasUnion]);
}
