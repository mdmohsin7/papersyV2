import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/filter/models/filter_state.dart';
import 'package:papersy/client/models/course_model.dart';
import '../../../main_state.dart';
import '../../../unions/filter/filter_union.dart';

class PassCoursesAction extends ReduxAction<AppState> {
  final List<Course> coursesList;

  PassCoursesAction({this.coursesList});

  @override
  AppState reduce() {
    print(coursesList.length);
    return state.copy(
      filterState: FilterState(
        index: state.filterState.index,
        selectedVal: state.filterState.selectedVal,
        courses: coursesList,
        filterUnion: FilterUnion.loaded(),
        selectedVals: state.filterState.selectedVals,
        getNotified: state.filterState.getNotified,
      ),
    );
  }
}
