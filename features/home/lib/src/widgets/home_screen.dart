import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../l10n/home_l10n.dart';
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
    final theme = AppTheme.of(context);
    final l10n = HomeL10n.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.title,
          style: AppTextStyles.loraRegularHeadline,
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorColor: theme.colors.indicatorColor,
          labelColor: theme.colors.labelColor,
          unselectedLabelColor: theme.colors.unselectedLabelColor,
          labelStyle: AppTextStyles.openRegularTitleSemiBold,
          tabAlignment: TabAlignment.center,
          tabs: [
            Tab(text: l10n.restaurantsTab),
            Tab(text: l10n.bookmarksTab),
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
