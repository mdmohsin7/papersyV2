import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:async_redux/local_persist.dart';
import 'package:connectivity/connectivity.dart';
import 'package:papersy/business/core/filter/actions/fetch_courses_action.dart';
import 'package:papersy/business/core/home/actions/extras_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/services/firestore_service.dart';
import 'package:papersy/business/unions/extras/extras_union.dart';
import 'package:papersy/business/unions/notes/notes_union.dart';
import 'package:papersy/business/unions/papers/papers_union.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/models/extra_model.dart';
import 'package:papersy/client/models/notes_model.dart';
import 'package:papersy/client/models/papers_model.dart';

import '../models/home_state.dart';
import 'check_auth_action.dart';
import 'notes_action.dart';
import 'papers_action.dart';

class HomeAction extends ReduxAction<AppState> {
  final int num;

  static List<Object> details;
  static Map<dynamic, dynamic> det;
  static Stream<List<Note>> notesList;
  static Stream<List<Paper>> papersList;
  static Stream<List<Extra>> extrasList;
  FireStoreService _fireStoreService = FireStoreService();
  HomeAction(this.num);

  @override
  Future<void> before() async {
    dispatch(WaitAction.add("fetching"));
    var sub = await Connectivity().checkConnectivity();
    if (sub == ConnectivityResult.none) {
      throw UserException(
        Values.noInternet,
      );
    } else {
      if (await LocalPersist("settings").exists()) {
        details = await LocalPersist("settings").load();
        det = details[0];
        notesList = await _fireStoreService.notesList(details: details[0]);
        papersList = await _fireStoreService.papersList(details: details[0]);
        extrasList = await _fireStoreService.extrasList(details: details[0]);
      }
    }
  }

  @override
  AppState reduce() {
    StreamSubscription notes;
    StreamSubscription papers;
    StreamSubscription extras;
    if (num == 0 && det != null) {
      notes = notesList.listen((event) {
        dispatch(NotesAction(notesList: event));
      });
      papers = papersList.listen((event) {
        dispatch(PapersAction(papersList: event));
      });
      extras = extrasList.listen((event) {
        dispatch(ExtrasAction(extrasList: event));
      });
      return state.copy(
        homeState: HomeState(
          papersUnion: PapersUnion.loading(),
          notesUnion: NotesUnion.loading(),
          extrasUnion: ExtrasUnion.loading(),
          index: state.homeState.index,
          notes: state.homeState.notes,
          papers: state.homeState.papers,
          extras: state.homeState.extras,
        ),
      );
    } else if (num == 1) {
      notes.cancel();
      papers.cancel();
      extras.cancel();
      return state.copy(
        homeState: HomeState(
          papersUnion: PapersUnion.none(),
          notesUnion: NotesUnion.none(),
          extrasUnion: ExtrasUnion.none(),
          index: state.homeState.index,
          notes: state.homeState.notes,
          papers: state.homeState.papers,
          extras: state.homeState.extras,
        ),
      );
    }
    return null;
  }

  @override
  void after() {
    dispatch(WaitAction.remove("fetching"));
  }

  @override
  Object wrapError(error) {
    return UserException(error.toString(), cause: error);
  }
}

void initAction(Store<AppState> state, int i) {
  return state.dispatch(HomeAction(i));
}

void checkAuthentication(Store<AppState> state) async {
  state.dispatch(FetchCoursesAction());
  await state.dispatchFuture(CheckAuthAction());
}

void disposeHomeAction(Store<AppState> state) {
  return state.dispatch(DisposeAction());
}

class DisposeAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return null;
  }
}
