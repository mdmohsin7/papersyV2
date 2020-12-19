// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'papers_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PapersUnionTearOff {
  const _$PapersUnionTearOff();

// ignore: unused_element
  None none() {
    return const None();
  }

// ignore: unused_element
  Loading loading() {
    return const Loading();
  }

// ignore: unused_element
  Loaded loaded() {
    return const Loaded();
  }

// ignore: unused_element
  Error error() {
    return const Error();
  }

// ignore: unused_element
  NoInternet noInternet() {
    return const NoInternet();
  }

// ignore: unused_element
  IsEmpty isEmpty() {
    return const IsEmpty();
  }
}

/// @nodoc
// ignore: unused_element
const $PapersUnion = _$PapersUnionTearOff();

/// @nodoc
mixin _$PapersUnion {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(),
    @required TResult noInternet(),
    @required TResult isEmpty(),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult loading(),
    TResult loaded(),
    TResult error(),
    TResult noInternet(),
    TResult isEmpty(),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(None value),
    @required TResult loading(Loading value),
    @required TResult loaded(Loaded value),
    @required TResult error(Error value),
    @required TResult noInternet(NoInternet value),
    @required TResult isEmpty(IsEmpty value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(None value),
    TResult loading(Loading value),
    TResult loaded(Loaded value),
    TResult error(Error value),
    TResult noInternet(NoInternet value),
    TResult isEmpty(IsEmpty value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $PapersUnionCopyWith<$Res> {
  factory $PapersUnionCopyWith(
          PapersUnion value, $Res Function(PapersUnion) then) =
      _$PapersUnionCopyWithImpl<$Res>;
}

/// @nodoc
class _$PapersUnionCopyWithImpl<$Res> implements $PapersUnionCopyWith<$Res> {
  _$PapersUnionCopyWithImpl(this._value, this._then);

  final PapersUnion _value;
  // ignore: unused_field
  final $Res Function(PapersUnion) _then;
}

/// @nodoc
abstract class $NoneCopyWith<$Res> {
  factory $NoneCopyWith(None value, $Res Function(None) then) =
      _$NoneCopyWithImpl<$Res>;
}

/// @nodoc
class _$NoneCopyWithImpl<$Res> extends _$PapersUnionCopyWithImpl<$Res>
    implements $NoneCopyWith<$Res> {
  _$NoneCopyWithImpl(None _value, $Res Function(None) _then)
      : super(_value, (v) => _then(v as None));

  @override
  None get _value => super._value as None;
}

/// @nodoc
class _$None implements None {
  const _$None();

  @override
  String toString() {
    return 'PapersUnion.none()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(),
    @required TResult noInternet(),
    @required TResult isEmpty(),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return none();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult loading(),
    TResult loaded(),
    TResult error(),
    TResult noInternet(),
    TResult isEmpty(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(None value),
    @required TResult loading(Loading value),
    @required TResult loaded(Loaded value),
    @required TResult error(Error value),
    @required TResult noInternet(NoInternet value),
    @required TResult isEmpty(IsEmpty value),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(None value),
    TResult loading(Loading value),
    TResult loaded(Loaded value),
    TResult error(Error value),
    TResult noInternet(NoInternet value),
    TResult isEmpty(IsEmpty value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class None implements PapersUnion {
  const factory None() = _$None;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$PapersUnionCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

/// @nodoc
class _$Loading implements Loading {
  const _$Loading();

  @override
  String toString() {
    return 'PapersUnion.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(),
    @required TResult noInternet(),
    @required TResult isEmpty(),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult loading(),
    TResult loaded(),
    TResult error(),
    TResult noInternet(),
    TResult isEmpty(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(None value),
    @required TResult loading(Loading value),
    @required TResult loaded(Loaded value),
    @required TResult error(Error value),
    @required TResult noInternet(NoInternet value),
    @required TResult isEmpty(IsEmpty value),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(None value),
    TResult loading(Loading value),
    TResult loaded(Loaded value),
    TResult error(Error value),
    TResult noInternet(NoInternet value),
    TResult isEmpty(IsEmpty value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements PapersUnion {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $LoadedCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) then) =
      _$LoadedCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadedCopyWithImpl<$Res> extends _$PapersUnionCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(Loaded _value, $Res Function(Loaded) _then)
      : super(_value, (v) => _then(v as Loaded));

  @override
  Loaded get _value => super._value as Loaded;
}

/// @nodoc
class _$Loaded implements Loaded {
  const _$Loaded();

  @override
  String toString() {
    return 'PapersUnion.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(),
    @required TResult noInternet(),
    @required TResult isEmpty(),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult loading(),
    TResult loaded(),
    TResult error(),
    TResult noInternet(),
    TResult isEmpty(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(None value),
    @required TResult loading(Loading value),
    @required TResult loaded(Loaded value),
    @required TResult error(Error value),
    @required TResult noInternet(NoInternet value),
    @required TResult isEmpty(IsEmpty value),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(None value),
    TResult loading(Loading value),
    TResult loaded(Loaded value),
    TResult error(Error value),
    TResult noInternet(NoInternet value),
    TResult isEmpty(IsEmpty value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements PapersUnion {
  const factory Loaded() = _$Loaded;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$PapersUnionCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;
}

/// @nodoc
class _$Error implements Error {
  const _$Error();

  @override
  String toString() {
    return 'PapersUnion.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Error);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(),
    @required TResult noInternet(),
    @required TResult isEmpty(),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return error();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult loading(),
    TResult loaded(),
    TResult error(),
    TResult noInternet(),
    TResult isEmpty(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(None value),
    @required TResult loading(Loading value),
    @required TResult loaded(Loaded value),
    @required TResult error(Error value),
    @required TResult noInternet(NoInternet value),
    @required TResult isEmpty(IsEmpty value),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(None value),
    TResult loading(Loading value),
    TResult loaded(Loaded value),
    TResult error(Error value),
    TResult noInternet(NoInternet value),
    TResult isEmpty(IsEmpty value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements PapersUnion {
  const factory Error() = _$Error;
}

/// @nodoc
abstract class $NoInternetCopyWith<$Res> {
  factory $NoInternetCopyWith(
          NoInternet value, $Res Function(NoInternet) then) =
      _$NoInternetCopyWithImpl<$Res>;
}

/// @nodoc
class _$NoInternetCopyWithImpl<$Res> extends _$PapersUnionCopyWithImpl<$Res>
    implements $NoInternetCopyWith<$Res> {
  _$NoInternetCopyWithImpl(NoInternet _value, $Res Function(NoInternet) _then)
      : super(_value, (v) => _then(v as NoInternet));

  @override
  NoInternet get _value => super._value as NoInternet;
}

/// @nodoc
class _$NoInternet implements NoInternet {
  const _$NoInternet();

  @override
  String toString() {
    return 'PapersUnion.noInternet()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NoInternet);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(),
    @required TResult noInternet(),
    @required TResult isEmpty(),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return noInternet();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult loading(),
    TResult loaded(),
    TResult error(),
    TResult noInternet(),
    TResult isEmpty(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (noInternet != null) {
      return noInternet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(None value),
    @required TResult loading(Loading value),
    @required TResult loaded(Loaded value),
    @required TResult error(Error value),
    @required TResult noInternet(NoInternet value),
    @required TResult isEmpty(IsEmpty value),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(None value),
    TResult loading(Loading value),
    TResult loaded(Loaded value),
    TResult error(Error value),
    TResult noInternet(NoInternet value),
    TResult isEmpty(IsEmpty value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class NoInternet implements PapersUnion {
  const factory NoInternet() = _$NoInternet;
}

/// @nodoc
abstract class $IsEmptyCopyWith<$Res> {
  factory $IsEmptyCopyWith(IsEmpty value, $Res Function(IsEmpty) then) =
      _$IsEmptyCopyWithImpl<$Res>;
}

/// @nodoc
class _$IsEmptyCopyWithImpl<$Res> extends _$PapersUnionCopyWithImpl<$Res>
    implements $IsEmptyCopyWith<$Res> {
  _$IsEmptyCopyWithImpl(IsEmpty _value, $Res Function(IsEmpty) _then)
      : super(_value, (v) => _then(v as IsEmpty));

  @override
  IsEmpty get _value => super._value as IsEmpty;
}

/// @nodoc
class _$IsEmpty implements IsEmpty {
  const _$IsEmpty();

  @override
  String toString() {
    return 'PapersUnion.isEmpty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is IsEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(),
    @required TResult noInternet(),
    @required TResult isEmpty(),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return isEmpty();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult loading(),
    TResult loaded(),
    TResult error(),
    TResult noInternet(),
    TResult isEmpty(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (isEmpty != null) {
      return isEmpty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(None value),
    @required TResult loading(Loading value),
    @required TResult loaded(Loaded value),
    @required TResult error(Error value),
    @required TResult noInternet(NoInternet value),
    @required TResult isEmpty(IsEmpty value),
  }) {
    assert(none != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    assert(noInternet != null);
    assert(isEmpty != null);
    return isEmpty(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(None value),
    TResult loading(Loading value),
    TResult loaded(Loaded value),
    TResult error(Error value),
    TResult noInternet(NoInternet value),
    TResult isEmpty(IsEmpty value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (isEmpty != null) {
      return isEmpty(this);
    }
    return orElse();
  }
}

abstract class IsEmpty implements PapersUnion {
  const factory IsEmpty() = _$IsEmpty;
}
