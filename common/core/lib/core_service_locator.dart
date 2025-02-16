import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/di/dependency_injection.dart';
import 'src/network/auth_http_client.dart';
import 'src/network/http_client.dart';

Future<void> initServiceLocator() async {
  final apiKey = dotenv.env['YELP_API_KEY'];
  di.registerFactory<HttpClient>(
    () => AuthHttpClient(
      dio: Dio(),
      apiKey: apiKey ?? '',
    ),
  );
}
