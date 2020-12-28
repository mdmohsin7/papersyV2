import 'package:freezed_annotation/freezed_annotation.dart';

part 'extras_union.freezed.dart';

@freezed
abstract class ExtrasUnion{
  const factory ExtrasUnion.loading() = Loading;
  const factory ExtrasUnion.loaded() = Loaded;
  const factory ExtrasUnion.noInternet() = NoInternet;
  const factory ExtrasUnion.error() = Error;
  const factory ExtrasUnion.none() =None;
  const factory ExtrasUnion.isEmpty() = IsEmpty;
}