import 'package:equatable/equatable.dart';

class HttpRequest extends Equatable {
  const HttpRequest({
    required this.path,
    this.payload,
    this.queryParameters,
  });

  final String path;
  final dynamic payload;
  final Map<String, dynamic>? queryParameters;

  @override
  bool? get stringify => true;

  @override
  List get props => [path, payload, queryParameters];
}
