import 'package:dio/dio.dart';

import '../../domain/architecture/failure.dart';

class DioAuthorizationFailure extends DioException
    implements UnauthorizedFailure {
  DioAuthorizationFailure({
    required super.requestOptions,
    required super.response,
  });

  @override
  bool get isFatal => true;

  @override
  String toString() {
    return 'AuthorizationFailure: ${requestOptions.uri} | ${response?.statusCode} | ${response?.data}';
  }
}

class DioServerFailure extends DioException implements UnknownFailure {
  DioServerFailure({
    required super.requestOptions,
    required super.response,
  });

  @override
  bool get isFatal => true;

  @override
  String toString() {
    return 'ServerFailure: ${requestOptions.uri} | ${response?.statusCode} | ${response?.data}';
  }
}
