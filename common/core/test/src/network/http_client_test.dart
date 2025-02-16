import 'package:core/src/network/http_client.dart';
import 'package:core/src/network/models/http_request.dart';
import 'package:core/src/network/models/http_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockInterceptors extends Mock implements Interceptors {}

class MockDio extends Mock implements Dio {
  MockDio({
    required this.mockInterceptors,
  }) : super();

  final Interceptors mockInterceptors;

  // By default, mock objects return null for unmocked properties.
  // Ensuring `interceptors` is initialized to prevent null errors in tests.
  @override
  Interceptors get interceptors => mockInterceptors;
}

void main() {
  late MockInterceptors mockInterceptors;
  late MockDio mockDio;
  late HttpClient httpClient;
  const commonRequest = HttpRequest(path: '/test');
  final expectedResponse = HttpResponse(
    request: commonRequest,
    headers: const {},
    statusCode: 200,
    data: const {'message': 'success'},
  );

  setUp(() {
    mockInterceptors = MockInterceptors();
    mockDio = MockDio(mockInterceptors: mockInterceptors);
    httpClient = HttpClientImpl(dio: mockDio);
  });

  void setupSuccessResponse({
    required HttpRequest request,
    int statusCode = 200,
  }) {
    final mockResponse = Response(
      requestOptions: RequestOptions(path: request.path),
      data: {'message': 'success'},
      statusCode: statusCode,
    );

    when(
      () => mockDio.request(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).thenAnswer((_) async => mockResponse);
  }

  void setupFailureResponse({
    required HttpRequest request,
    int? statusCode,
    required String errorMessage,
  }) {
    when(
      () => mockDio.request(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: request.path),
        response: Response(
          requestOptions: RequestOptions(path: request.path),
          statusCode: statusCode,
        ),
        error: errorMessage,
      ),
    );
  }

  group('Success requests', () {
    test('GET request should return a valid response', () async {
      setupSuccessResponse(request: commonRequest);

      final response = await httpClient.get(commonRequest);
      expect(response, expectedResponse);
    });

    test('POST request should return a valid response', () async {
      setupSuccessResponse(request: commonRequest);

      final response = await httpClient.post(commonRequest);
      expect(response, expectedResponse);
    });

    test('PUT request should return a valid response', () async {
      setupSuccessResponse(request: commonRequest);

      final response = await httpClient.put(commonRequest);
      expect(response, expectedResponse);
    });

    test('PATCH request should return a valid response', () async {
      setupSuccessResponse(request: commonRequest);

      final response = await httpClient.patch(commonRequest);
      expect(response, expectedResponse);
    });

    test('DELETE request should return a valid response', () async {
      setupSuccessResponse(request: commonRequest);

      final response = await httpClient.delete(commonRequest);
      expect(response, expectedResponse);
    });
  });

  group('Failure and cancelled requests', () {
    test('Should throw HttpErrorResponse on DioException with status code',
        () async {
      setupFailureResponse(
        request: commonRequest,
        statusCode: 500,
        errorMessage: 'Server error',
      );

      expect(
        () async => await httpClient.post(commonRequest),
        throwsA(isA<HttpErrorResponse>()),
      );
    });

    test('Should throw HttpErrorResponse on DioException without status code',
        () async {
      setupFailureResponse(
        request: commonRequest,
        errorMessage: 'No internet',
      );

      expect(
        () async => await httpClient.post(commonRequest),
        throwsA(isA<HttpErrorResponse>()),
      );
    });

    test('Cancel should clear interceptors', () {
      httpClient.cancel();

      verify(() => mockInterceptors.clear()).called(1);
    });
  });
}
