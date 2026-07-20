import '../error/exceptions.dart';
import '../error/failure_mapper.dart';
import '../error/failures.dart';



sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;

  const factory Result.failure(Failure failure) = FailureResult<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  T? get valueOrNull => switch (this) {
        Success<T>(:final value) => value,
        FailureResult<T>() => null,
      };

  Failure? get failureOrNull => switch (this) {
        FailureResult<T>(:final failure) => failure,
        Success<T>() => null,
      };


  R fold<R>(
    R Function(T value) onSuccess,
    R Function(Failure failure) onFailure,
  ) =>
      switch (this) {
        Success<T>(:final value) => onSuccess(value),
        FailureResult<T>(:final failure) => onFailure(failure),
      };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Success<T>(:final value) => Success<R>(transform(value)),
        FailureResult<T>(:final failure) => FailureResult<R>(failure),
      };
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);
  final Failure failure;
}


Future<Result<T>> guardAsync<T>(Future<T> Function() body) async {
  try {
    return Result<T>.success(await body());
  } on AppException catch (e) {
    return Result<T>.failure(mapExceptionToFailure(e));
  } catch (_) {
    return Result<T>.failure(const UnknownFailure());
  }
}
