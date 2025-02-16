import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'app_service_locator.dart';
import 'models/restaurant.dart';
import 'query.dart';

const _baseUrl = 'https://api.yelp.com/v3/graphql';

void main() async {
  await initAppDependencies();
  runApp(const RestaurantTour());
}

class RestaurantTour extends StatelessWidget {
  const RestaurantTour({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Restaurant Tour',
      home: HomePage(),
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Restaurant Tour'),
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
