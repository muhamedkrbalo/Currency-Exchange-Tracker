// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrencyRate {

 String get code; String get name; double get rateInEgp; double get previousRateInEgp; DateTime get lastUpdated;
/// Create a copy of CurrencyRate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyRateCopyWith<CurrencyRate> get copyWith => _$CurrencyRateCopyWithImpl<CurrencyRate>(this as CurrencyRate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyRate&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.rateInEgp, rateInEgp) || other.rateInEgp == rateInEgp)&&(identical(other.previousRateInEgp, previousRateInEgp) || other.previousRateInEgp == previousRateInEgp)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,rateInEgp,previousRateInEgp,lastUpdated);

@override
String toString() {
  return 'CurrencyRate(code: $code, name: $name, rateInEgp: $rateInEgp, previousRateInEgp: $previousRateInEgp, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $CurrencyRateCopyWith<$Res>  {
  factory $CurrencyRateCopyWith(CurrencyRate value, $Res Function(CurrencyRate) _then) = _$CurrencyRateCopyWithImpl;
@useResult
$Res call({
 String code, String name, double rateInEgp, double previousRateInEgp, DateTime lastUpdated
});




}
/// @nodoc
class _$CurrencyRateCopyWithImpl<$Res>
    implements $CurrencyRateCopyWith<$Res> {
  _$CurrencyRateCopyWithImpl(this._self, this._then);

  final CurrencyRate _self;
  final $Res Function(CurrencyRate) _then;

/// Create a copy of CurrencyRate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? rateInEgp = null,Object? previousRateInEgp = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rateInEgp: null == rateInEgp ? _self.rateInEgp : rateInEgp // ignore: cast_nullable_to_non_nullable
as double,previousRateInEgp: null == previousRateInEgp ? _self.previousRateInEgp : previousRateInEgp // ignore: cast_nullable_to_non_nullable
as double,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrencyRate].
extension CurrencyRatePatterns on CurrencyRate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrencyRate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrencyRate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrencyRate value)  $default,){
final _that = this;
switch (_that) {
case _CurrencyRate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrencyRate value)?  $default,){
final _that = this;
switch (_that) {
case _CurrencyRate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  double rateInEgp,  double previousRateInEgp,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrencyRate() when $default != null:
return $default(_that.code,_that.name,_that.rateInEgp,_that.previousRateInEgp,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  double rateInEgp,  double previousRateInEgp,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _CurrencyRate():
return $default(_that.code,_that.name,_that.rateInEgp,_that.previousRateInEgp,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  double rateInEgp,  double previousRateInEgp,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _CurrencyRate() when $default != null:
return $default(_that.code,_that.name,_that.rateInEgp,_that.previousRateInEgp,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _CurrencyRate extends CurrencyRate {
  const _CurrencyRate({required this.code, required this.name, required this.rateInEgp, required this.previousRateInEgp, required this.lastUpdated}): super._();
  

@override final  String code;
@override final  String name;
@override final  double rateInEgp;
@override final  double previousRateInEgp;
@override final  DateTime lastUpdated;

/// Create a copy of CurrencyRate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyRateCopyWith<_CurrencyRate> get copyWith => __$CurrencyRateCopyWithImpl<_CurrencyRate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrencyRate&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.rateInEgp, rateInEgp) || other.rateInEgp == rateInEgp)&&(identical(other.previousRateInEgp, previousRateInEgp) || other.previousRateInEgp == previousRateInEgp)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,rateInEgp,previousRateInEgp,lastUpdated);

@override
String toString() {
  return 'CurrencyRate(code: $code, name: $name, rateInEgp: $rateInEgp, previousRateInEgp: $previousRateInEgp, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$CurrencyRateCopyWith<$Res> implements $CurrencyRateCopyWith<$Res> {
  factory _$CurrencyRateCopyWith(_CurrencyRate value, $Res Function(_CurrencyRate) _then) = __$CurrencyRateCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, double rateInEgp, double previousRateInEgp, DateTime lastUpdated
});




}
/// @nodoc
class __$CurrencyRateCopyWithImpl<$Res>
    implements _$CurrencyRateCopyWith<$Res> {
  __$CurrencyRateCopyWithImpl(this._self, this._then);

  final _CurrencyRate _self;
  final $Res Function(_CurrencyRate) _then;

/// Create a copy of CurrencyRate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? rateInEgp = null,Object? previousRateInEgp = null,Object? lastUpdated = null,}) {
  return _then(_CurrencyRate(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rateInEgp: null == rateInEgp ? _self.rateInEgp : rateInEgp // ignore: cast_nullable_to_non_nullable
as double,previousRateInEgp: null == previousRateInEgp ? _self.previousRateInEgp : previousRateInEgp // ignore: cast_nullable_to_non_nullable
as double,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
