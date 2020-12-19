import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_union.freezed.dart';

@freezed
abstract class NotesUnion with _$NotesUnion{
  const factory NotesUnion.none() = None;
  const factory NotesUnion.loading() = Loading;
  const factory NotesUnion.loaded() = Loaded;
  const factory NotesUnion.noInternet() =NoInternet;
  const factory NotesUnion.error() = Error;
  const factory NotesUnion.isEmpty() = IsEmpty;
}