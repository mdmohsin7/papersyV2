import 'package:freezed_annotation/freezed_annotation.dart';

part 'papers_union.freezed.dart';

@freezed
abstract class PapersUnion with _$PapersUnion {
  const factory PapersUnion.none() = None;
  const factory PapersUnion.loading() = Loading;
  const factory PapersUnion.loaded() = Loaded;
  const factory PapersUnion.error() = Error;
  const factory PapersUnion.noInternet() = NoInternet;
  const factory PapersUnion.isEmpty() = IsEmpty;
}
