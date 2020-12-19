import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/download/actions/download_action.dart';
import 'package:papersy/business/core/download/actions/preview_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/notes/notes_union.dart';
import 'package:papersy/business/core/user_activity/actions/report_action.dart';
import 'package:papersy/business/core/user_activity/actions/upvote_action.dart';
import 'package:papersy/client/models/notes_model.dart';

import 'notes_widget.dart';

class NotesVM extends VmFactory<AppState, Notes> {
  NotesVM(widget) : super(widget);

  @override
  NVM fromStore() {
    return NVM(
      isFetching: state.wait.isWaitingFor("fetching"),
      notesList: (state.homeState).notes,
      download: (subject, college, link) => dispatch(
        DownloadAction(subject: subject, college: college, link: link),
      ),
      preview: (url) {
        print("new: $url");
        dispatch(PreviewAction(url: url));
      },
      votesCount: state.userActivityState.votesCount,
      vote: () => dispatch(UpvoteAction()),
      isUpvoted: state.userActivityState.isUpvoted,
      report: (type, course, branch, sem) => dispatch(
        ReportAction(
          type: type,
          course: course,
          branch: branch,
          sem: sem,
        ),
      ),
      notesUnion: state.homeState.notesUnion,
    );
  }
}

class NVM extends Vm {
  final List<Note> notesList;
  final Function(String, String, String) download;
  final bool isFetching;
  final int votesCount;
  final Function vote;
  final bool isUpvoted;
  final Function(String) preview;
  final Function(String, String, String, String) report;
  final NotesUnion notesUnion;

  NVM(
      {this.preview,
      this.notesUnion,
      this.isFetching,
      this.notesList,
      this.download,
      this.votesCount,
      this.vote,
      this.isUpvoted,
      this.report})
      : super(equals: [notesList, votesCount, isUpvoted, notesUnion]);
}
