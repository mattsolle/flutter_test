import 'dart:convert';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../l10n/home_l10n.dart';
import '../restaurants/blocs/restaurants_cubit.dart';
import '../restaurants/data/models/restaurant.dart';
import '../restaurants/data/queries/query.dart';
import '../restaurants/widgets/restaurants_container.dart';

const _baseUrl = 'https://api.yelp.com/v3/graphql';

// TODO: Architect code
// This is just a POC of the API integration
class HomeScreenOld extends StatelessWidget {
  const HomeScreenOld({super.key});

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
    final l10n = HomeL10n.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.title,
              style: AppTextStyles.loraRegularHeadline,
            ),
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'RestauranTour',
          style: AppTextStyles.loraRegularHeadline,
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: AppTextStyles.openRegularTitleSemiBold,
          tabAlignment: TabAlignment.center,
          tabs: const [
            Tab(text: 'All Restaurants'),
            Tab(text: 'My Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RestaurantsCubitProvider(
            child: RestaurantsContainer(),
          ),
          const LoadingWidget(),
        ],
      ),
    );
  }
}
