import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/core/constants/app_tabs.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/tab_navigation/tab_navigation_cubit.dart';

class RestaurantsScreen extends StatelessWidget {
  final Widget child;
  const RestaurantsScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabNavigationCubit, TabNavigationState>(
      builder: (context, state) {
        final int tabIndex = state.selectedIndex;

        return DefaultTabController(
          length: AppTabs.items.length,
          initialIndex: tabIndex,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.appTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              bottom: TabBar(
                onTap: (index) => _navigateToTab(context, index),
                tabs: AppTabs.items.map((tab) => Tab(text: tab.title)).toList(),
              ),
            ),
            body: child,
          ),
        );
      },
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    final cubit = context.read<TabNavigationCubit>();
    final routeName = cubit.getRoute(index);

    if (ModalRoute.of(context)?.settings.name != routeName) {
      cubit.navigateToTab(index);
      context.goNamed(routeName);
    }
  }
}
