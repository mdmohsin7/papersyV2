import 'package:equatable/equatable.dart';

class PreviewState extends Equatable {
  final int index;

  PreviewState({this.index});

  PreviewState copy({int index}) {
    return PreviewState(index: index ?? this.index);
  }

  static PreviewState initialState() => PreviewState(index: 0);

  @override
  List<Object> get props => [index];
}
