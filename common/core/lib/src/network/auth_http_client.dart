import 'dart:io';

import 'package:dio/dio.dart';

import 'http_client.dart';

class AuthHttpClient extends HttpClientImpl {
  AuthHttpClient({
    required super.dio,
    required this.apiKey,
  });

  final String apiKey;

  @override
  Future<Options> getOptions() async {
    return Options(
      contentType: 'application/graphql',
      responseType: ResponseType.json,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiKey',
      },
    );
  }
}
