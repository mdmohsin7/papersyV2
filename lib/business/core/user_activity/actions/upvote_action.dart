import 'package:async_redux/async_redux.dart';
import 'package:papersy/business/main_state.dart';

class UpvoteAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    // if (state.userActivityState.isUpvoted == false) {
    //   return state.copy(
    //     userActivityState: UserActivityState(
    //       isUpvoted: true,
    //       votesCount: state.userActivityState.votesCount + 1,
    //     ),
    //   );
    // } else {
    //   return null;
    // }
    throw UserException(
        "Upvoting/Downvoting is only (as of now) availabe to closed alpha testers. It will be rolled out to public soon :)");
  }

  @override
  Object wrapError(error) {
    return UserException(error.toString());
  }
}
