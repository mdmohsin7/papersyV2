import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/download/actions/download_action.dart';
import 'package:papersy/business/core/download/actions/preview_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/papers/papers_union.dart';
import 'package:papersy/business/core/user_activity/actions/report_action.dart';
import 'package:papersy/client/models/papers_model.dart';

import 'papers_widget.dart';

class PapersVM extends VmFactory<AppState, Papers> {
  PapersVM(widget) : super(widget);

  @override
  PVM fromStore() {
    return PVM(
      papersList: state.homeState.papers,
      download: (sub, year, link) => dispatch(
        DownloadAction(
          subject: sub,
          college: year,
          link: link,
        ),
      ),
      preview: (url) => dispatch(PreviewAction(url: url)),
      report: (type, course, sem, branch) => dispatch(
        ReportAction(type: type, course: course, sem: sem, branch: branch),
      ),
      papersUnion: state.homeState.papersUnion,
    );
  }
}

class PVM extends Vm {
  final List<Paper> papersList;
  final Function(String) preview;
  final Function(String, String, String) download;
  final Function(String, String, String, String) report;
  final PapersUnion papersUnion;

  PVM(
      {this.report,
      this.preview,
      this.download,
      this.papersList,
      this.papersUnion})
      : super(equals: [papersList, papersUnion]);
}
