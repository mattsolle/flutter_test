import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/core/di/service_locator.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/favourite_restaurants/favourite_restaurants_cubit.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/tab_navigation/tab_navigation_cubit.dart';

import 'core/theme/app_theme.dart';
import 'core/observer/bloc_observer.dart';
import 'features/restaurant/presentation/blocs/restaurant/restaurant_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  await setupLocator();

  Bloc.observer = getIt<AppBlocObserver>();

  runApp(const RestaurantTour());
}

class RestaurantTour extends StatelessWidget {
  const RestaurantTour({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<TabNavigationCubit>()),
        BlocProvider<RestaurantBloc>(
          create: (context) =>
              getIt<RestaurantBloc>()..add(FetchRestaurantsEvent(0)),
        ),
        BlocProvider(create: (context) => getIt<FavoriteRestaurantsCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: getIt<GoRouter>(),
      ),
    );
  }
}
