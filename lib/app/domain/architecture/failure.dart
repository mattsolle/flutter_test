abstract class Failure implements Exception {
  const Failure(this.stackTrace);

  final StackTrace stackTrace;

  bool get isFatal;
}

class SerializationFailure extends Failure {
  const SerializationFailure(this.error, StackTrace stackTrace)
      : super(stackTrace);

  final dynamic error;

  @override
  bool get isFatal => true;
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.stackTrace);

  @override
  bool get isFatal => true;
}

class UnknownFailure extends Failure {
  const UnknownFailure(this.message, super.stackTrace);

  final dynamic message;

  @override
  bool get isFatal => true;

  @override
  String toString() {
    final Object? message = this.message;

    if (message == null) {
      return 'UnknownFailure';
    }

    return 'UnknownFailure: $message';
  }
}

class RestaurantNotFoundFailure extends Failure {
  const RestaurantNotFoundFailure(
    super.stackTrace, {
    required this.id,
  });

  final String id;

  @override
  bool get isFatal => false;

  @override
  String toString() {
    return 'RestaurantNotFoundFailure: $id';
  }
}
