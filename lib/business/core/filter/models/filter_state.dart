import 'package:equatable/equatable.dart';
import 'package:papersy/client/models/course_model.dart';
import '../../../unions/filter/filter_union.dart';

class FilterState extends Equatable {
  final dynamic selectedVal;
  final int index;
  final List<CourseModel> courses;
  final Map<dynamic, dynamic> selectedVals;
  final bool getNotified;
  final FilterUnion filterUnion;

  FilterState(
      {this.selectedVal,
      this.index,
      this.courses,
      this.selectedVals,
      this.getNotified,
      this.filterUnion});

  FilterState copy(
      {dynamic selectedVal,
      int index,
      List<CourseModel> courses,
      List<dynamic> selectedVals,
      bool getNotified,
      FilterUnion filterUnion}) {
    return FilterState(
      selectedVal: selectedVal ?? this.selectedVal,
      index: index ?? this.index,
      courses: courses ?? this.courses,
      selectedVals: selectedVals ?? this.selectedVals,
      getNotified: getNotified ?? this.getNotified,
      filterUnion: filterUnion ?? this.filterUnion,
    );
  }

  static FilterState initialState() => FilterState(
        selectedVal: null,
        index: 0,
        courses: [],
        selectedVals: {},
        filterUnion: None(),
        getNotified: false,
      );

  @override
  List<Object> get props =>
      [selectedVal, index, courses, selectedVals, filterUnion, getNotified];
}
