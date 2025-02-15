import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'http_request.dart';

class HttpResponse extends Equatable {
  HttpResponse({
    dynamic data,
    required this.request,
    required this.headers,
    required this.statusCode,
  })  : dataJson = data != null ? jsonEncode(data) : null,
        super();

  final String? dataJson;
  final Map<String, List<String>> headers;
  final int? statusCode;
  final HttpRequest request;

  @override
  bool? get stringify => true;

  @override
  List get props => [dataJson, headers, statusCode, request];
}

class HttpErrorResponse extends Equatable {
  const HttpErrorResponse({
    required this.request,
    this.message,
    this.error,
    this.headers,
    this.statusCode,
  });

  final HttpRequest request;
  final String? message;
  final dynamic error;
  final Map<String, List<String>>? headers;
  final int? statusCode;

  @override
  List get props => [request, message, error, headers, statusCode];
}
