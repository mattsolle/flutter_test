import 'failure.dart';

class Result<T> {
  const Result.failure(this._failure) : _success = null;

  const Result.success(this._success) : _failure = null;

  factory Result.failureFromCatch(dynamic e, StackTrace s) {
    if (e is Failure) {
      return Result.failure(e);
    }

    return Result.failure(UnknownFailure(e, s));
  }

  final T? _success;

  final Failure? _failure;

  bool get isSuccess => _success != null;

  bool get isFailure => _failure != null;

  T get success {
    return _success as T;
  }

  Failure get failure {
    return _failure!;
  }
}
