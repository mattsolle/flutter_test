import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioRequestCachingInterceptor extends Interceptor {
  const DioRequestCachingInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.method != 'POST' || !options.path.contains('graphql')) {
      handler.next(options);
      return;
    }

    final data = options.data;

    late final String key;

    if (data is String) {
      key = _generateRequestKey(data);
    } else {
      key = _generateRequestKey(jsonEncode(data));
    }

    final prefs = await SharedPreferences.getInstance();
    final cachedResponse = prefs.getString(key);

    if (cachedResponse == null) {
      handler.next(options);
      return;
    }

    final cacheTTL = _CacheTTLModel.fromJson(cachedResponse);
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    const delay4Hours = 60 * 60 * 4 * 1000;

    if (currentTime - cacheTTL.timestamp > delay4Hours) {
      await prefs.remove(key);
      handler.next(options);
      return;
    }

    final response = Response(
      requestOptions: options,
      data: cacheTTL.data,
      statusCode: 200,
    );

    response.headers.add('cachedResponseTime', cacheTTL.timestamp.toString());
    handler.resolve(response);
    return;
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final request = response.requestOptions;
    final timestamp = request.headers['cachedResponseTime'];

    if (timestamp != null) {
      handler.next(response);
      return;
    }

    if (response.statusCode != 200) {
      handler.next(response);
      return;
    }

    if (request.method != 'POST' || !request.path.contains('graphql')) {
      handler.next(response);
      return;
    }

    final requestData = request.data;

    late final String key;

    if (requestData is String) {
      key = _generateRequestKey(requestData);
    } else {
      key = _generateRequestKey(jsonEncode(requestData));
    }

    final prefs = await SharedPreferences.getInstance();

    final cacheTTL = _CacheTTLModel(
      DateTime.now().millisecondsSinceEpoch,
      response.data as Map<String, dynamic>,
    );

    await prefs.setString(key, cacheTTL.toJson());
    handler.next(response);
  }

  String _generateRequestKey(String jsonString) {
    return sha256.convert(utf8.encode(jsonString)).toString();
  }
}

class _CacheTTLModel {
  const _CacheTTLModel(
    this.timestamp,
    this.data,
  );

  factory _CacheTTLModel.fromJson(String jsonStr) {
    final Map<String, dynamic> json = jsonDecode(jsonStr);

    return _CacheTTLModel(
      json['timestamp'] as int,
      json['data'] as Map<String, dynamic>,
    );
  }

  final int timestamp;
  final Map<String, dynamic> data;

  String toJson() {
    return jsonEncode({
      'timestamp': timestamp,
      'data': data,
    });
  }
}
