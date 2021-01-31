import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/filter/actions/checkbox_action.dart';
import 'package:papersy/business/core/filter/actions/filter_action.dart';
import '../../../business/core/filter/actions/save_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/client/models/course_model.dart';
import 'package:papersy/client/screens/filter/filter_widget.dart';
import '../../../business/unions/filter/filter_union.dart';

class FilterVM extends VmFactory<AppState, FilterWidget> {
  FilterVM() : super();
  @override
  FVM fromStore() {
    return FVM(
      save: ()  =>  dispatch(SaveAction()),
      selectedValue: state.filterState.selectedVal,
      index: state.filterState.index,
      onChange: (dynamic) => dispatch(DropDownAction(dynamic)),
      coursesList: (state.filterState).courses,
      update: (bool) => dispatch(IndexAction(bool)),
      selectedVals: state.filterState.selectedVals,
      filterUnion: state.filterState.filterUnion,
      getNotified: state.filterState.getNotified,
      updateCheckbox: (value) => dispatch(CheckBoxAction(value: value)),
    );
  }
}

class FVM extends Vm {
  final int index;
  final dynamic selectedValue;
  final Function(dynamic) onChange;
  final Function(bool) update;
  final Function save;
  final List<Course> coursesList;
  final Map<dynamic, dynamic> selectedVals;
  final bool getNotified;
  final FilterUnion filterUnion;
  final Function(bool) updateCheckbox;

  FVM(
      {this.index,
      this.selectedValue,
      this.onChange,
      this.update,
      this.save,
      this.coursesList,
      this.selectedVals,
      this.getNotified,
      this.updateCheckbox,
      this.filterUnion})
      : super(equals: [
          index,
          selectedVals,
          selectedValue,
          coursesList,
          filterUnion,
          getNotified
        ]);
}
