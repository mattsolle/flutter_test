import 'package:core/go_router.dart';
import 'package:flutter/widgets.dart';

import 'app_routes_config.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/',
      routes: AppRoutesConfig.getRoutes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Router(
      key: const Key('app-router'),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
