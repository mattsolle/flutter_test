import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/restaurant_entity.dart';
import '../../utils/assets.dart';
import '../../utils/extensions/app_localization_extension.dart';
import '../../utils/extensions/context_extension.dart';
import '../../utils/extensions/image_provider_extension.dart';
import '../app/app_router.dart';
import 'bloc/restaurant_list_bloc.dart';
import 'bloc/restaurant_list_bloc_events.dart';
import 'bloc/restaurant_list_bloc_states.dart';
import 'components/restaurant_list_tile.dart';
import 'components/tab_bar_delegate_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.restaurantListBloc,
  });

  final RestaurantListBloc restaurantListBloc;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RestaurantListBloc get bloc => widget.restaurantListBloc;

  int offset = 0;
  int tabIndex = 0;

  late final StreamSubscription? subscription;
  final List<RestaurantEntity> restaurants = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    subscription = bloc.stream.listen(onState);
    scrollController.addListener(onScroll);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        loadRestaurants();
      },
    );
  }

  void onScroll() {
    if (scrollController.position.pixels <
        (scrollController.position.maxScrollExtent - 16 * 2)) {
      return;
    }

    final state = bloc.state;

    if (state is! LoadedRestaurantListState) {
      return;
    }

    if (state.isLoadingMore) {
      return;
    }

    if (state.result.total == restaurants.length) {
      return;
    }

    bloc.add(
      GetRestaurantsEvent(
        offset: offset,
        favorites: tabIndex == 1,
      ),
    );
  }

  void onState(RestaurantListBlocState state) {
    if (state is! LoadedRestaurantListState) {
      return;
    }

    if (state.isLoadingMore) {
      return;
    }

    if (offset == 0) {
      restaurants.clear();
    }

    restaurants.addAll(state.result.restaurants ?? []);
    offset = restaurants.length;
  }

  void loadRestaurants() {
    bloc.add(
      GetRestaurantsEvent(
        offset: offset,
        favorites: tabIndex == 1,
      ),
    );
  }

  void onChangeTab(int index) {
    tabIndex = index;
    offset = 0;
    loadRestaurants();
  }

  Future<void> onRefresh() async {
    offset = 0;

    bloc.add(
      GetRestaurantsEvent(
        offset: offset,
        favorites: tabIndex == 1,
      ),
    );
  }

  void onTap(RestaurantEntity restaurant) {
    context.pushNamed(
      AppRouter.restaurantDetails,
      pathParameters: {
        'id': restaurant.id ?? '',
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: BlocBuilder<RestaurantListBloc, RestaurantListBlocState>(
            bloc: bloc,
            builder: (context, state) {
              return NestedScrollView(
                controller: scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16 * 2,
                      ),
                      child: Text(
                        context.l10n.restaurantTour,
                        style: context.appTypography.loraRegularHeadline,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: TabBarDelegateComponent(
                      onTap: onChangeTab,
                    ),
                  ),
                ],
                body: switch (state) {
                  LoadingRestaurantListState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  LoadedRestaurantListState(
                    isLoadingMore: final isLoadingMore
                  ) =>
                    RefreshIndicator(
                      onRefresh: onRefresh,
                      child: ListView.builder(
                        itemCount: restaurants.length + 1,
                        padding: const EdgeInsets.all(8),
                        prototypeItem: const RestaurantListTileWidget(
                          image: AssetImage(Assets.placeHolder),
                          name:
                              'Restaurant Name That has probably a very long name',
                          price: 'Price',
                          rating: 4.5,
                          isOpen: true,
                          tags: ['short tag'],
                        ),
                        itemBuilder: (context, index) {
                          if (index >= restaurants.length) {
                            if (isLoadingMore) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return const SizedBox();
                          }

                          final restaurant = restaurants[index];

                          return RestaurantListTileWidget(
                            image: restaurant
                                .heroImage.toImageProvider.orDefaultImage,
                            name: restaurant.name ?? '',
                            price: restaurant.price,
                            rating: restaurant.rating,
                            isOpen: restaurant.hours?.firstOrNull?.isOpenNow ??
                                false,
                            tags: restaurant.categories
                                    ?.map((e) => e.title ?? '')
                                    .toList() ??
                                [],
                            onTap: () => onTap(restaurant),
                          );
                        },
                      ),
                    ),
                  ErrorRestaurantListState() => const Center(
                      child: Text('Error loading restaurants'),
                    ),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
