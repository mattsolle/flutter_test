import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:i18n/i18next.dart';

import 'app_service_locator.dart';
import 'l10n/main_l10n.dart';
import 'models/restaurant.dart';
import 'query.dart';
import 'src/splash/splash_screen.dart';

const _baseUrl = 'https://api.yelp.com/v3/graphql';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppDependencies();
  runApp(
    I18nProvider.fromAssetBundle(
      i18nextOptions: I18NextOptions(
        formats: formatters,
        missingInterpolationHandler: interpolationFallback,
      ),
      child: const RestaurantTour(),
    ),
  );
}

class RestaurantTour extends StatelessWidget {
  const RestaurantTour({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = I18nProvider.of(context);
    return MaterialApp(
      title: 'Restaurant Tour',
      supportedLocales: i18n.supportedLocales,
      localizationsDelegates: i18n.localizationsDelegates,
      home: SplashScreen(
        onAnimationDone: () {
          print('onAnimationDone');
        },
      ),
    );
  }
}

// TODO: Architect code
// This is just a POC of the API integration
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    try {
      final client = di<HttpClient>();
      final response = await client.post(
        HttpRequest(
          path: _baseUrl,
          payload: query(offset),
        ),
      );

      if (response.statusCode == 200) {
        return RestaurantQueryResult.fromJson(
          jsonDecode(response.dataJson!)['data']['search'],
        );
      } else {
        print('Failed to load restaurants: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching restaurants: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = MainL10n.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.title),
            ElevatedButton(
              child: const Text('Fetch Restaurants'),
              onPressed: () async {
                try {
                  final result = await getRestaurants();
                  if (result != null) {
                    print('Fetched ${result.restaurants!.length} restaurants');
                  } else {
                    print('No restaurants fetched');
                  }
                } catch (e) {
                  print('Failed to fetch restaurants: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
