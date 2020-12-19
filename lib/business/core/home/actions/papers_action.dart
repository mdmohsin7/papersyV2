import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/home/models/home_state.dart';
import 'package:papersy/business/unions/papers/papers_union.dart';
import 'package:papersy/client/models/papers_model.dart';

import '../../../main_state.dart';


class PapersAction extends ReduxAction<AppState> {
  List<Paper> papersList;
  PapersAction({this.papersList});

  @override
  AppState reduce() {
    if (papersList.isEmpty) {
      return state.copy(
        homeState: HomeState(
          notesUnion: state.homeState.notesUnion,
          notes: state.homeState.notes,
          index: state.homeState.index,
          papers: papersList,
          papersUnion: PapersUnion.isEmpty(),
        ),
      );
    } else {
      return state.copy(
        homeState: HomeState(
          notesUnion: state.homeState.notesUnion,
          notes: state.homeState.notes,
          index: state.homeState.index,
          papers: papersList,
          papersUnion: PapersUnion.loaded(),
        ),
      );
    }
  }
}
