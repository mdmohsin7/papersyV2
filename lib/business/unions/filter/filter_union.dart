import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_union.freezed.dart';

@freezed
abstract class FilterUnion with _$FilterUnion {
  const factory FilterUnion.loading() = Loading;
  const factory FilterUnion.loaded() = Loaded;
  const factory FilterUnion.noInternet() = NoInternet;
  const factory FilterUnion.error() = Error;
  const factory FilterUnion.none() =None;
}
