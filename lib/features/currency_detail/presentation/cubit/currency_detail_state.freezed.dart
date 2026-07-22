// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrencyDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrencyDetailState()';
}


}

/// @nodoc
class $CurrencyDetailStateCopyWith<$Res>  {
$CurrencyDetailStateCopyWith(CurrencyDetailState _, $Res Function(CurrencyDetailState) __);
}


/// Adds pattern-matching-related methods to [CurrencyDetailState].
extension CurrencyDetailStatePatterns on CurrencyDetailState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CurrencyDetailInitial value)?  initial,TResult Function( CurrencyDetailLoading value)?  loading,TResult Function( CurrencyDetailLoaded value)?  loaded,TResult Function( CurrencyDetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CurrencyDetailInitial() when initial != null:
return initial(_that);case CurrencyDetailLoading() when loading != null:
return loading(_that);case CurrencyDetailLoaded() when loaded != null:
return loaded(_that);case CurrencyDetailError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CurrencyDetailInitial value)  initial,required TResult Function( CurrencyDetailLoading value)  loading,required TResult Function( CurrencyDetailLoaded value)  loaded,required TResult Function( CurrencyDetailError value)  error,}){
final _that = this;
switch (_that) {
case CurrencyDetailInitial():
return initial(_that);case CurrencyDetailLoading():
return loading(_that);case CurrencyDetailLoaded():
return loaded(_that);case CurrencyDetailError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CurrencyDetailInitial value)?  initial,TResult? Function( CurrencyDetailLoading value)?  loading,TResult? Function( CurrencyDetailLoaded value)?  loaded,TResult? Function( CurrencyDetailError value)?  error,}){
final _that = this;
switch (_that) {
case CurrencyDetailInitial() when initial != null:
return initial(_that);case CurrencyDetailLoading() when loading != null:
return loading(_that);case CurrencyDetailLoaded() when loaded != null:
return loaded(_that);case CurrencyDetailError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<HistoricalRate> history)?  loaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CurrencyDetailInitial() when initial != null:
return initial();case CurrencyDetailLoading() when loading != null:
return loading();case CurrencyDetailLoaded() when loaded != null:
return loaded(_that.history);case CurrencyDetailError() when error != null:
return error(_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<HistoricalRate> history)  loaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case CurrencyDetailInitial():
return initial();case CurrencyDetailLoading():
return loading();case CurrencyDetailLoaded():
return loaded(_that.history);case CurrencyDetailError():
return error(_that.failure);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<HistoricalRate> history)?  loaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case CurrencyDetailInitial() when initial != null:
return initial();case CurrencyDetailLoading() when loading != null:
return loading();case CurrencyDetailLoaded() when loaded != null:
return loaded(_that.history);case CurrencyDetailError() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class CurrencyDetailInitial implements CurrencyDetailState {
  const CurrencyDetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrencyDetailState.initial()';
}


}




/// @nodoc


class CurrencyDetailLoading implements CurrencyDetailState {
  const CurrencyDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrencyDetailState.loading()';
}


}




/// @nodoc


class CurrencyDetailLoaded implements CurrencyDetailState {
  const CurrencyDetailLoaded(final  List<HistoricalRate> history): _history = history;
  

 final  List<HistoricalRate> _history;
 List<HistoricalRate> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyDetailLoadedCopyWith<CurrencyDetailLoaded> get copyWith => _$CurrencyDetailLoadedCopyWithImpl<CurrencyDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailLoaded&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'CurrencyDetailState.loaded(history: $history)';
}


}

/// @nodoc
abstract mixin class $CurrencyDetailLoadedCopyWith<$Res> implements $CurrencyDetailStateCopyWith<$Res> {
  factory $CurrencyDetailLoadedCopyWith(CurrencyDetailLoaded value, $Res Function(CurrencyDetailLoaded) _then) = _$CurrencyDetailLoadedCopyWithImpl;
@useResult
$Res call({
 List<HistoricalRate> history
});




}
/// @nodoc
class _$CurrencyDetailLoadedCopyWithImpl<$Res>
    implements $CurrencyDetailLoadedCopyWith<$Res> {
  _$CurrencyDetailLoadedCopyWithImpl(this._self, this._then);

  final CurrencyDetailLoaded _self;
  final $Res Function(CurrencyDetailLoaded) _then;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(CurrencyDetailLoaded(
null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<HistoricalRate>,
  ));
}


}

/// @nodoc


class CurrencyDetailError implements CurrencyDetailState {
  const CurrencyDetailError(this.failure);
  

 final  Failure failure;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyDetailErrorCopyWith<CurrencyDetailError> get copyWith => _$CurrencyDetailErrorCopyWithImpl<CurrencyDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CurrencyDetailState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CurrencyDetailErrorCopyWith<$Res> implements $CurrencyDetailStateCopyWith<$Res> {
  factory $CurrencyDetailErrorCopyWith(CurrencyDetailError value, $Res Function(CurrencyDetailError) _then) = _$CurrencyDetailErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$CurrencyDetailErrorCopyWithImpl<$Res>
    implements $CurrencyDetailErrorCopyWith<$Res> {
  _$CurrencyDetailErrorCopyWithImpl(this._self, this._then);

  final CurrencyDetailError _self;
  final $Res Function(CurrencyDetailError) _then;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(CurrencyDetailError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
