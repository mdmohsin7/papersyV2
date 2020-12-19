import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/home/models/home_state.dart';
import 'package:papersy/business/unions/notes/notes_union.dart';
import 'package:papersy/client/models/notes_model.dart';

import '../../../main_state.dart';

class NotesAction extends ReduxAction<AppState> {
  List<Note> notesList;
  NotesAction({this.notesList});

  @override
  AppState reduce() {
    if (notesList.isEmpty) {
      return state.copy(
        homeState: HomeState(
          notes: notesList,
          index: state.homeState.index,
          notesUnion: NotesUnion.isEmpty(),
          papers: state.homeState.papers,
          papersUnion: state.homeState.papersUnion,
        ),
      );
    } else {
      print("notes1 : ${notesList.length}");
      return state.copy(
        homeState: HomeState(
          notes: notesList,
          index: state.homeState.index,
          notesUnion: NotesUnion.loaded(),
          papers: state.homeState.papers,
          papersUnion: state.homeState.papersUnion,
        ),
      );
    }
  }
}
