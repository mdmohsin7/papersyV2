import 'package:equatable/equatable.dart';

class UserActivityState extends Equatable{
  final bool isUpvoted;
  final int votesCount;

  UserActivityState({this.isUpvoted, this.votesCount});

  UserActivityState copy({bool isUpvoted, int votesCOunt}) {
    return UserActivityState(
      isUpvoted: isUpvoted ?? this.isUpvoted,
      votesCount: votesCount ?? this.votesCount,
    );
  }

  static UserActivityState initialState() =>
      UserActivityState(isUpvoted: false, votesCount: 0);

  @override
  List<Object> get props => [isUpvoted, votesCount];
}
