import 'package:dio/dio.dart';

import '../../domain/architecture/constants.dart';
import '../../domain/services/authorization_service.dart';
import '../architecture/data_failures.dart';

class DioAuthorizationInterceptor extends Interceptor
    implements AuthorizationService {
  DioAuthorizationInterceptor();

  String? bearer;

  bool validateStatus(int? status) {
    return status != null &&
        (status >= 200 && status < 300 || status == 401 || status == 500);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (bearer != null) {
      options.headers.addAll({
        'Authorization': 'Bearer $bearer',
      });
    }

    options.validateStatus = validateStatus;
    options.baseUrl = Constants.baseUrl;
    options.contentType = 'application/graphql';

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      handler.reject(
        DioAuthorizationFailure(
          requestOptions: err.requestOptions,
          response: err.response,
        ),
      );
    }

    handler.next(
      DioServerFailure(
        requestOptions: err.requestOptions,
        response: err.response,
      ),
    );
  }

  @override
  void removeBearer() {
    bearer = null;
  }

  @override
  void setBearer(String token) {
    bearer = token;
  }
}
