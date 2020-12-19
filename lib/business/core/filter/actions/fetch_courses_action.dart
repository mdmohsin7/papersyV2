import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:papersy/business/core/filter/models/filter_state.dart';
import 'package:papersy/client/models/course_model.dart';
import '../../../main_state.dart';
import '../../../unions/filter/filter_union.dart';

import 'pass_data_action.dart';

class FetchCoursesAction extends ReduxAction<AppState> {
  static Stream<List<CourseModel>> coursesList = FirebaseFirestore.instanceFor(
    app: Firebase.app("v2"),
  ).collection("Courses").snapshots().asBroadcastStream().map((snap) =>
      snap.docs.map((doc) => CourseModel.fromFirestore(doc)).toList());

  @override
  AppState reduce() {
    coursesList.listen((event) {
      dispatch(PassDataAction(coursesList: event));
    });
    return state.copy(
      filterState: FilterState(
        courses: state.filterState.courses,
        index: state.filterState.index,
        selectedVal: state.filterState.selectedVal,
        selectedVals: state.filterState.selectedVals,
        filterUnion: FilterUnion.loaded(),
        getNotified: state.filterState.getNotified,
      ),
    );
  }
}
