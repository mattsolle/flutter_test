import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../restaurants/blocs/bookmarked_restaurants_cubit.dart';
import '../restaurants/blocs/restaurants_cubit.dart';
import '../restaurants/widgets/bookmarked_restaurants_container.dart';
import '../restaurants/widgets/restaurants_container.dart';

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
          BookmarkedRestaurantsCubitProvider(
            child: BookmarkedRestaurantsContainer(),
          ),
        ],
      ),
    );
  }
}
