import 'dart:developer';

import 'package:dio/dio.dart';

class LogInterceptor extends Interceptor {
  LogInterceptor({
    required this.requestHeaders,
    this.responseHeaders,
    this.responseData,
    this.error,
  }) : super();

  final bool requestHeaders;
  final bool? responseHeaders, responseData;
  final bool? error;

  void _log(String message, [Object? error, StackTrace? stackTrace]) {
    log(message, error: error, stackTrace: stackTrace, name: 'Http');
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final buffer = StringBuffer('**** (coding challenge) HTTP REQUEST:\n');
    buffer.writeln('uri: ${options.uri}');

    if (requestHeaders) {
      buffer.writeln('headers:');
      options.headers.forEach((key, value) => buffer.writeln('  $key: $value'));
    }
    if (options.data != null) {
      buffer.writeln('data:');
      buffer.writeln('  ${options.data}');
    }

    _log(buffer.toString());
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final buffer = StringBuffer('**** (coding challenge) HTTP SUCCESS:\n');
    buffer
      ..writeln(
        '${response.requestOptions.method} ${response.requestOptions.uri}',
      )
      ..writeln('status code: ${response.statusCode}');
    if (responseHeaders != null) {
      buffer.writeln('headers:');
      response.headers
          .forEach((key, value) => buffer.writeln('  $key: $value'));
    }
    if (responseData != null) {
      buffer.writeln('data: ${response.toString()}');
    }

    _log(buffer.toString());
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error != null) {
      final buffer = StringBuffer('**** (coding challenge) HTTP ERROR:\n');
      buffer.writeln('${err.requestOptions.method} ${err.requestOptions.uri}');
      if (err.response != null) {
        buffer
          ..writeln('status code: ${err.response?.statusCode}')
          ..writeln('data: ${err.response.toString()}');
      }
      _log(buffer.toString());
    }
    super.onError(err, handler);
  }
}
