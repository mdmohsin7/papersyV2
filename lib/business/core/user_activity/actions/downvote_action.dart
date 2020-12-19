import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/core/user_activity/models/user_activity_state.dart';

class DownVoteAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copy(
      userActivityState: UserActivityState(
        isUpvoted: false,
        votesCount: state.userActivityState.votesCount - 1,
      ),
    );
  }
}
