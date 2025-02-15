import 'package:dio/dio.dart' hide LogInterceptor;
import 'package:flutter/foundation.dart';

import 'log_interceptor.dart';
import 'models/http_request.dart';
import 'models/http_response.dart';

abstract class HttpClient {
  Future<HttpResponse> get(HttpRequest request);
  Future<HttpResponse> post(HttpRequest request);
  Future<HttpResponse> put(HttpRequest request);
  Future<HttpResponse> patch(HttpRequest request);
  Future<HttpResponse> delete(HttpRequest request);
  void cancel();
}

class HttpClientImpl extends HttpClient {
  HttpClientImpl({
    required this.dio,
  }) {
    dio.interceptors.addAll([
      if (kDebugMode)
        LogInterceptor(
          requestHeaders: true,
          responseData: true,
          responseHeaders: true,
          error: true,
        ),
    ]);
  }

  final Dio dio;

  Future<Options> getOptions() {
    return Future.value(
      Options(responseType: ResponseType.json),
    );
  }

  Future<HttpResponse> _makeRequest(
    String method,
    HttpRequest request,
  ) {
    return getOptions()
        .then((options) {
          return options.copyWith(method: method);
        })
        .then((options) => dio.request(
              request.path,
              queryParameters: request.queryParameters,
              data: request.payload,
              options: options,
            ))
        .then(
          (onValue) => HttpResponse(
            request: request,
            headers: onValue.headers.map,
            statusCode: onValue.statusCode,
            data: onValue.data,
          ),
          onError: (error, stackTrace) {
            if (error is DioException) {
              throw HttpErrorResponse(
                request: request,
                error: error.error,
                message: error.message,
                statusCode: error.response?.statusCode,
                headers: error.response?.headers.map,
              );
            }
            throw error;
          },
        );
  }

  @override
  Future<HttpResponse> get(HttpRequest request) {
    return _makeRequest('GET', request);
  }

  @override
  Future<HttpResponse> post(HttpRequest request) {
    return _makeRequest('POST', request);
  }

  @override
  Future<HttpResponse> put(HttpRequest request) {
    return _makeRequest('PUT', request);
  }

  @override
  Future<HttpResponse> patch(HttpRequest request) {
    return _makeRequest('PATCH', request);
  }

  @override
  Future<HttpResponse> delete(HttpRequest request) {
    return _makeRequest('DELETE', request);
  }

  @override
  void cancel() {
    return dio.interceptors.clear();
  }
}
