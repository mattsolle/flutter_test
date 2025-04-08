import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_tour/core/utils/app_logger.dart';
import '../constants/config.dart';

class ApiClient {
  final http.Client client;
  final AppLogger logger;

  ApiClient({required this.client, required this.logger});

  Future<Map<String, dynamic>> postRequest(String query) async {
    final headers = {
      'Authorization': 'Bearer $yelpApiKey',
      'Content-Type': 'application/json',
    };

    try {
      final response = await client.post(
        Uri.parse(yelpGraphQLUrl),
        headers: headers,
        body: jsonEncode({"query": query}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        logger
            .logError("HTTP Error: ${response.statusCode} - ${response.body}");
        throw ApiException(response.statusCode, response.body);
      }
    } catch (e, stackTrace) {
      logger.logError(
        "Network Request Failed: $e",
        error: e,
        stackTrace: stackTrace,
      );
      throw ApiException(-1, "Network Error: $e");
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => "ApiException: $statusCode - $message";
}
