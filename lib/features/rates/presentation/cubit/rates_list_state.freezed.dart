// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rates_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RatesListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatesListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RatesListState()';
}


}

/// @nodoc
class $RatesListStateCopyWith<$Res>  {
$RatesListStateCopyWith(RatesListState _, $Res Function(RatesListState) __);
}


/// Adds pattern-matching-related methods to [RatesListState].
extension RatesListStatePatterns on RatesListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RatesListInitial value)?  initial,TResult Function( RatesListLoading value)?  loading,TResult Function( RatesListLoaded value)?  loaded,TResult Function( RatesListError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RatesListInitial() when initial != null:
return initial(_that);case RatesListLoading() when loading != null:
return loading(_that);case RatesListLoaded() when loaded != null:
return loaded(_that);case RatesListError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RatesListInitial value)  initial,required TResult Function( RatesListLoading value)  loading,required TResult Function( RatesListLoaded value)  loaded,required TResult Function( RatesListError value)  error,}){
final _that = this;
switch (_that) {
case RatesListInitial():
return initial(_that);case RatesListLoading():
return loading(_that);case RatesListLoaded():
return loaded(_that);case RatesListError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RatesListInitial value)?  initial,TResult? Function( RatesListLoading value)?  loading,TResult? Function( RatesListLoaded value)?  loaded,TResult? Function( RatesListError value)?  error,}){
final _that = this;
switch (_that) {
case RatesListInitial() when initial != null:
return initial(_that);case RatesListLoading() when loading != null:
return loading(_that);case RatesListLoaded() when loaded != null:
return loaded(_that);case RatesListError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CurrencyRate> rates,  bool isFromCache,  DateTime? lastUpdated)?  loaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RatesListInitial() when initial != null:
return initial();case RatesListLoading() when loading != null:
return loading();case RatesListLoaded() when loaded != null:
return loaded(_that.rates,_that.isFromCache,_that.lastUpdated);case RatesListError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CurrencyRate> rates,  bool isFromCache,  DateTime? lastUpdated)  loaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case RatesListInitial():
return initial();case RatesListLoading():
return loading();case RatesListLoaded():
return loaded(_that.rates,_that.isFromCache,_that.lastUpdated);case RatesListError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CurrencyRate> rates,  bool isFromCache,  DateTime? lastUpdated)?  loaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case RatesListInitial() when initial != null:
return initial();case RatesListLoading() when loading != null:
return loading();case RatesListLoaded() when loaded != null:
return loaded(_that.rates,_that.isFromCache,_that.lastUpdated);case RatesListError() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class RatesListInitial implements RatesListState {
  const RatesListInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatesListInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RatesListState.initial()';
}


}




/// @nodoc


class RatesListLoading implements RatesListState {
  const RatesListLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatesListLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RatesListState.loading()';
}


}




/// @nodoc


class RatesListLoaded implements RatesListState {
  const RatesListLoaded({required final  List<CurrencyRate> rates, required this.isFromCache, this.lastUpdated}): _rates = rates;
  

 final  List<CurrencyRate> _rates;
 List<CurrencyRate> get rates {
  if (_rates is EqualUnmodifiableListView) return _rates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rates);
}

 final  bool isFromCache;
 final  DateTime? lastUpdated;

/// Create a copy of RatesListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatesListLoadedCopyWith<RatesListLoaded> get copyWith => _$RatesListLoadedCopyWithImpl<RatesListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatesListLoaded&&const DeepCollectionEquality().equals(other._rates, _rates)&&(identical(other.isFromCache, isFromCache) || other.isFromCache == isFromCache)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rates),isFromCache,lastUpdated);

@override
String toString() {
  return 'RatesListState.loaded(rates: $rates, isFromCache: $isFromCache, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $RatesListLoadedCopyWith<$Res> implements $RatesListStateCopyWith<$Res> {
  factory $RatesListLoadedCopyWith(RatesListLoaded value, $Res Function(RatesListLoaded) _then) = _$RatesListLoadedCopyWithImpl;
@useResult
$Res call({
 List<CurrencyRate> rates, bool isFromCache, DateTime? lastUpdated
});




}
/// @nodoc
class _$RatesListLoadedCopyWithImpl<$Res>
    implements $RatesListLoadedCopyWith<$Res> {
  _$RatesListLoadedCopyWithImpl(this._self, this._then);

  final RatesListLoaded _self;
  final $Res Function(RatesListLoaded) _then;

/// Create a copy of RatesListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rates = null,Object? isFromCache = null,Object? lastUpdated = freezed,}) {
  return _then(RatesListLoaded(
rates: null == rates ? _self._rates : rates // ignore: cast_nullable_to_non_nullable
as List<CurrencyRate>,isFromCache: null == isFromCache ? _self.isFromCache : isFromCache // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class RatesListError implements RatesListState {
  const RatesListError(this.failure);
  

 final  Failure failure;

/// Create a copy of RatesListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatesListErrorCopyWith<RatesListError> get copyWith => _$RatesListErrorCopyWithImpl<RatesListError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatesListError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'RatesListState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RatesListErrorCopyWith<$Res> implements $RatesListStateCopyWith<$Res> {
  factory $RatesListErrorCopyWith(RatesListError value, $Res Function(RatesListError) _then) = _$RatesListErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$RatesListErrorCopyWithImpl<$Res>
    implements $RatesListErrorCopyWith<$Res> {
  _$RatesListErrorCopyWithImpl(this._self, this._then);

  final RatesListError _self;
  final $Res Function(RatesListError) _then;

/// Create a copy of RatesListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(RatesListError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
