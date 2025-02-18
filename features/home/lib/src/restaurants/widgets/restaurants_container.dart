import 'package:core/core.dart';
import 'package:core/flutter_bloc.dart';
import 'package:core/go_router.dart';
import 'package:design_system/design_system.dart';

import '../blocs/restaurants_cubit.dart';
import '../blocs/restaurants_state.dart';
import '../l10n/errors_l10n.dart';
import 'restaurants_screen.dart';

class RestaurantsContainer
    extends BlocBuilder<RestaurantsCubit, RestaurantsState> {
  RestaurantsContainer({super.key})
      : super(
          builder: (context, state) {
            final l10n = ErrorsL10n.of(context);
            if (state.status == RestaurantsStatus.loading) {
              return const LoadingWidget();
            } else if (state.status == RestaurantsStatus.error) {
              return ErrorWidget(message: l10n.common);
            } else if (state.status == RestaurantsStatus.yelpLimit) {
              return ErrorWidget(message: l10n.yelp);
            } else {
              return RestaurantsScreen(
                controller: state.controller,
                onRestaurantPressed: (restaurant) {
                  context.goNamed(RouteNames.restaurant, extra: restaurant);
                },
              );
            }
          },
        );
}
