import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../home/home_route.dart';
import '../restaurant_details/restaurant_details_route.dart';
import '../splash/splash_route.dart';

class AppRouter {
  AppRouter(this.i);

  final GetIt i;

  static const String home = '/home';
  static const String splash = '/splash';
  static const String restaurantDetails = '/restaurantDetails';


  late final router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      SplashRoute(i).route,
      HomeRoute(i).route,
      RestaurantDetails(i).route,
    ],
  );
}
