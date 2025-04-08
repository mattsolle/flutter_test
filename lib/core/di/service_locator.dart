import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_tour/core/network/api_client.dart';
import 'package:restaurant_tour/core/observer/bloc_observer.dart';
import 'package:restaurant_tour/core/routes/app_router.dart';
import 'package:restaurant_tour/core/utils/app_logger.dart';
import 'package:restaurant_tour/features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_tour/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_tour/features/restaurant/domain/use_cases/fetch_restaurants.dart';
import 'package:restaurant_tour/features/restaurant/presentation/blocs/restaurant/restaurant_bloc.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/favourite_restaurants/favourite_restaurants_cubit.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/tab_navigation/tab_navigation_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
// Register AppRouter
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<GoRouter>(() => getIt<AppRouter>().router);

  // Register AppLogger
  getIt.registerLazySingleton(
    () => AppLogger(logger: Logger(printer: PrettyPrinter())),
  );

  //Register AppBlocObserver
  getIt
      .registerLazySingleton(() => AppBlocObserver(logger: getIt<AppLogger>()));

  // Register http.Client
  getIt.registerLazySingleton(() => http.Client());

  // Register ApiClient
  getIt.registerLazySingleton(
    () => ApiClient(client: getIt<http.Client>(), logger: getIt<AppLogger>()),
  );

  // Register Repository as an Interface
  getIt.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(getIt<ApiClient>(), getIt<AppLogger>()),
  );

  // Register Use Case
  getIt.registerLazySingleton(
    () => FetchRestaurants(getIt<RestaurantRepository>()),
  );

  // Register RestaurantBloc
  getIt.registerFactory(
    () => RestaurantBloc(getIt<FetchRestaurants>(), getIt<AppLogger>()),
  );

  // Register FavoriteRestaurantsCubit
  getIt.registerLazySingleton<FavoriteRestaurantsCubit>(
    () => FavoriteRestaurantsCubit(),
  );

  // Register TabNavigationCubit
  getIt.registerLazySingleton(() => TabNavigationCubit());
}
