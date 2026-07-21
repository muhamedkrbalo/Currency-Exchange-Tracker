// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'historical_rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoricalRate {

 DateTime get date; double get rateInEgp;
/// Create a copy of HistoricalRate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalRateCopyWith<HistoricalRate> get copyWith => _$HistoricalRateCopyWithImpl<HistoricalRate>(this as HistoricalRate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalRate&&(identical(other.date, date) || other.date == date)&&(identical(other.rateInEgp, rateInEgp) || other.rateInEgp == rateInEgp));
}


@override
int get hashCode => Object.hash(runtimeType,date,rateInEgp);

@override
String toString() {
  return 'HistoricalRate(date: $date, rateInEgp: $rateInEgp)';
}


}

/// @nodoc
abstract mixin class $HistoricalRateCopyWith<$Res>  {
  factory $HistoricalRateCopyWith(HistoricalRate value, $Res Function(HistoricalRate) _then) = _$HistoricalRateCopyWithImpl;
@useResult
$Res call({
 DateTime date, double rateInEgp
});




}
/// @nodoc
class _$HistoricalRateCopyWithImpl<$Res>
    implements $HistoricalRateCopyWith<$Res> {
  _$HistoricalRateCopyWithImpl(this._self, this._then);

  final HistoricalRate _self;
  final $Res Function(HistoricalRate) _then;

/// Create a copy of HistoricalRate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? rateInEgp = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,rateInEgp: null == rateInEgp ? _self.rateInEgp : rateInEgp // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoricalRate].
extension HistoricalRatePatterns on HistoricalRate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalRate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalRate() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalRate value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalRate():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalRate value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalRate() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double rateInEgp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoricalRate() when $default != null:
return $default(_that.date,_that.rateInEgp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double rateInEgp)  $default,) {final _that = this;
switch (_that) {
case _HistoricalRate():
return $default(_that.date,_that.rateInEgp);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double rateInEgp)?  $default,) {final _that = this;
switch (_that) {
case _HistoricalRate() when $default != null:
return $default(_that.date,_that.rateInEgp);case _:
  return null;

}
}

}

/// @nodoc


class _HistoricalRate implements HistoricalRate {
  const _HistoricalRate({required this.date, required this.rateInEgp});
  

@override final  DateTime date;
@override final  double rateInEgp;

/// Create a copy of HistoricalRate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalRateCopyWith<_HistoricalRate> get copyWith => __$HistoricalRateCopyWithImpl<_HistoricalRate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalRate&&(identical(other.date, date) || other.date == date)&&(identical(other.rateInEgp, rateInEgp) || other.rateInEgp == rateInEgp));
}


@override
int get hashCode => Object.hash(runtimeType,date,rateInEgp);

@override
String toString() {
  return 'HistoricalRate(date: $date, rateInEgp: $rateInEgp)';
}


}

/// @nodoc
abstract mixin class _$HistoricalRateCopyWith<$Res> implements $HistoricalRateCopyWith<$Res> {
  factory _$HistoricalRateCopyWith(_HistoricalRate value, $Res Function(_HistoricalRate) _then) = __$HistoricalRateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double rateInEgp
});




}
/// @nodoc
class __$HistoricalRateCopyWithImpl<$Res>
    implements _$HistoricalRateCopyWith<$Res> {
  __$HistoricalRateCopyWithImpl(this._self, this._then);

  final _HistoricalRate _self;
  final $Res Function(_HistoricalRate) _then;

/// Create a copy of HistoricalRate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? rateInEgp = null,}) {
  return _then(_HistoricalRate(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,rateInEgp: null == rateInEgp ? _self.rateInEgp : rateInEgp // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
