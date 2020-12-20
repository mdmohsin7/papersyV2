import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:async_redux/local_persist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:papersy/business/core/filter/actions/fetch_courses_action.dart';
import 'package:papersy/business/core/theme/actions/change_theme_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/notes/notes_union.dart';
import 'package:papersy/business/unions/papers/papers_union.dart';
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

  HomeAction(this.num);

  @override
  Future<void> before() async {
    if (await LocalPersist('theme').exists()) {
      var isDark = await LocalPersist('theme').load();
      Map a = isDark[0];
      print(a);
      dispatch(ChangeThemeAction(a['isDark']));
    }
    dispatch(WaitAction.add("fetching"));
    var sub = await Connectivity().checkConnectivity();
    if (sub == ConnectivityResult.none) {
      throw UserException(
        "Please check your internet connection and then try again",
      );
    } else {
      if (await LocalPersist("settings").exists()) {
        details = await LocalPersist("settings").load();
        det = details[0];
        print(det);
        notesList = FirebaseFirestore.instance
            .collection("Notes")
            .doc("${det["course"]}")
            .collection("${det["branch"]}")
            .doc("${det["semester"]}")
            .collection("SEM${det["semester"]}")
            .where("isv", isEqualTo: true)
            .snapshots()
            .map(
              (_ds) => _ds.docs.map((e) => Note.fromFirestore(e)).toList(),
            );
        papersList = FirebaseFirestore.instance
            .collection("Papers")
            .doc("${det["course"]}")
            .collection("${det["branch"]}")
            .doc("${det["semester"]}")
            .collection("SEM${det["semester"]}")
            .where("isv", isEqualTo: true)
            .snapshots()
            .map(
              (_ps) => _ps.docs.map((_p) => Paper.fromFirestore(_p)).toList(),
            );
      }
    }
  }

  @override
  AppState reduce() {
    StreamSubscription notes;
    StreamSubscription papers;
    if (num == 0 && det != null) {
      notes = notesList.listen((event) {
        print("listening");
        dispatch(NotesAction(notesList: event));
      });
      papers = papersList.listen((event) {
        dispatch(PapersAction(papersList: event));
      });
      return state.copy(
        homeState: HomeState(
          papersUnion: PapersUnion.loading(),
          notesUnion: NotesUnion.loading(),
          index: state.homeState.index,
          notes: state.homeState.notes,
          papers: state.homeState.papers,
        ),
      );
    } else if (num == 1) {
      notes.cancel();
      papers.cancel();
      return state.copy(
        homeState: HomeState(
          papersUnion: PapersUnion.none(),
          notesUnion: NotesUnion.none(),
          index: state.homeState.index,
          notes: state.homeState.notes,
          papers: state.homeState.papers,
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

void checkAuthentication(Store<AppState> state) {
  state.dispatch(FetchCoursesAction());
  state.dispatch(CheckAuthAction());
}

void disposeHomeAction(Store<AppState> state) {
  print("disposed");
  return state.dispatch(DisposeAction());
}

class DisposeAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return null;
  }
}
