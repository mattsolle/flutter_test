import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_tour/core/constants/app_tabs.dart';

part 'tab_navigation_state.dart';

class TabNavigationCubit extends Cubit<TabNavigationState> {
  TabNavigationCubit() : super(const TabNavigationInitial());

  void navigateToTab(int index) => emit(TabNavigationTabChanged(index));

  // Get Routes based on index
  String getRoute(int index) => AppTabs.items[index].routeName;
}
