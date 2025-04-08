part of 'tab_navigation_cubit.dart';

sealed class TabNavigationState extends Equatable {
  final int selectedIndex;
  const TabNavigationState(this.selectedIndex);

  @override
  List<Object> get props => [];
}

final class TabNavigationInitial extends TabNavigationState {
  const TabNavigationInitial() : super(0);
}

final class TabNavigationTabChanged extends TabNavigationState {
  const TabNavigationTabChanged(super.index);
}
