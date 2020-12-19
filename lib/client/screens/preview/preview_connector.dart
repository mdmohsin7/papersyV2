import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/core/preview/actions/preview_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/client/screens/preview/preview_widget.dart';

class PreviewVM extends VmFactory<AppState, PreviewWidget> {
  @override
  PreVM fromStore() {
    return PreVM(
      index: state.previewState.index,
      switchIndex: (index) => dispatch(PreviewAction(index: index)),
    );
  }
}

class PreVM extends Vm {
  final int index;
  final Function(int) switchIndex;

  PreVM({this.index, this.switchIndex}) : super(equals: [index]);
}
