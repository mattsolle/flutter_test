import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_tour/app/ui/features/restaurant_details/pages/restaurant_page.dart';

import '../../../utils/extensions/app_localization_extension.dart';
import '../bloc/restaurant_details_bloc.dart';
import '../bloc/restaurant_details_bloc_events.dart';
import '../bloc/restaurant_details_bloc_states.dart';

class RestaurantDetailsPage extends StatefulWidget {
  const RestaurantDetailsPage({
    super.key,
    required this.restaurantId,
    required this.bloc,
  });

  final String? restaurantId;
  final RestaurantDetailsBloc bloc;

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  RestaurantDetailsBloc get bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        loadRestaurant();
      },
    );
  }

  void loadRestaurant() {
    bloc.add(GetRestaurantDetailsEvent(widget.restaurantId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantDetailsBloc, RestaurantDetailsState>(
        bloc: bloc,
        builder: (context, state) => switch (state) {
          RestaurantDetailsLoadingState() => Scaffold(
              appBar: AppBar(
                title: Text(context.l10n.loading),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          RestaurantDetailsLoadedState(restaurantDetails: final restaurant) =>
            RestaurantPage(
              restaurantEntity: restaurant,
              isFavorite: false,
              onTapFavorite: () {

              },
            ),
          RestaurantDetailsErrorState() => Scaffold(
              appBar: AppBar(
                title: Text(context.l10n.error),
              ),
              body: Center(
                child: Text(
                  context.l10n.unexpectedErrorHappenedWhileLoadingTheRestaurant,
                ),
              ),
            ),
          RestaurantDetailsInvalidState() => Scaffold(
              appBar: AppBar(
                title: Text(context.l10n.error),
              ),
              body: Center(
                child: Text(
                  context.l10n.invalidRestaurant,
                ),
              ),
            ),
        },
      ),
    );
  }
}
