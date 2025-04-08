import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/core/network/api_client.dart';

import '../../../mocks.dart';

void main() {
  late ApiClient apiClient;
  late MockHttpClient mockHttpClient;
  late MockAppLogger mockLogger;

  setUpAll(() async {
    registerMockFallbackValues();
    await dotenv.load();
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockLogger = MockAppLogger();
    apiClient = ApiClient(client: mockHttpClient, logger: mockLogger);
  });

  const String query = "{ businesses { name } }";
  const String jsonResponse = '{"data": {"businesses": [{"name": "Test"}]}}';

  test('returns parsed JSON when status code is 200', () async {
    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(jsonResponse, 200));

    final result = await apiClient.postRequest(query);

    expect(result, isA<Map<String, dynamic>>());
  });

  test('logs error and throws ApiException on failure', () async {
    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenThrow(Exception("Network failure"));

    expect(
      () async => await apiClient.postRequest(query),
      throwsA(isA<ApiException>()),
    );

    // Ensure logError is called correctly
    verify(
      () => mockLogger.logError(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).called(1);
  });
}
