import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/home/models/home_state.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/extras/extras_union.dart';
import 'package:papersy/client/models/extra_model.dart';

class ExtrasAction extends ReduxAction<AppState> {
  List<Extra> extrasList;
  ExtrasAction({this.extrasList});
  @override
  AppState reduce() {
    if (extrasList.isEmpty) {
      return state.copy(
        homeState: HomeState(
          extras: extrasList,
          index: state.homeState.index,
          extrasUnion: ExtrasUnion.isEmpty(),
          papers: state.homeState.papers,
          papersUnion: state.homeState.papersUnion,
          notes: state.homeState.notes,
          notesUnion: state.homeState.notesUnion,
        ),
      );
    } else {
      print("notes1 : ${extrasList.length}");
      return state.copy(
        homeState: HomeState(
          extras: extrasList,
          index: state.homeState.index,
          extrasUnion: ExtrasUnion.loaded(),
          papers: state.homeState.papers,
          papersUnion: state.homeState.papersUnion,
          notes: state.homeState.notes,
          notesUnion: state.homeState.notesUnion,
        ),
      );
    }
  }
}
