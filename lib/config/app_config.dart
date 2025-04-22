class AppConfig {
  static const String yelpApiKey = String.fromEnvironment(
    '8kEHBik4nlQ58Pw_FIHpEWIkdFCBAn_JLflKdVi-zeV_RQDscuCLaENv-ZHJ0e2_rYbbLUxj9H07Z3_tneThKx6ZQKuFBqyrnqqxFOSnVPQMWJ2X12EK5kI9uVoGaHYx',
    defaultValue: '8kEHBik4nlQ58Pw_FIHpEWIkdFCBAn_JLflKdVi-zeV_RQDscuCLaENv-ZHJ0e2_rYbbLUxj9H07Z3_tneThKx6ZQKuFBqyrnqqxFOSnVPQMWJ2X12EK5kI9uVoGaHYx',
  );
  static const String yelpBaseUrl = 'https://api.yelp.com/v3/graphql';
} 