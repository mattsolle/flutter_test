final class Constants {
  const Constants._();

  static const String apiKey = String.fromEnvironment('API_KEY');
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'xxx');
  static const bool isProduction = bool.fromEnvironment('IS_PRODUCTION');
}
