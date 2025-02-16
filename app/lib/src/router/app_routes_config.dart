import 'package:core/go_router.dart';

import '../splash/splash_route.dart';

/// Abstract class for managing application routes.
///
/// This class serves as a centralized configuration for all app routes,
/// ensuring consistency and easy maintenance when using `GoRouter`.
///
/// ## Usage:
/// - Define all routes inside the `getRoutes` method.
///
/// Example:
/// ```dart
/// static List<RouteBase> getRoutes() => [
///   ExampleRoute(),
///   ...add your route here,
/// ];
/// ```
///
/// This approach helps maintain a structured and scalable navigation system.
abstract class AppRoutesConfig {
  AppRoutesConfig._();

  static List<RouteBase> getRoutes() => [
        SplashRoute(),
      ];
}
