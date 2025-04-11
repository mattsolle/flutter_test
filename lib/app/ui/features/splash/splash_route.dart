import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../app/app_router.dart';
import 'bloc/splash_bloc.dart';
import 'splash_page.dart';

class SplashRoute {
  SplashRoute(this.i);

  final GetIt i;

  late final GoRoute route = GoRoute(
    path: AppRouter.splash,
    builder: builder,
  );

  late final SplashBloc splashBloc = SplashBloc(
    i.get(),
  );

  Widget builder(BuildContext context, GoRouterState state) {
    return SplashPage(
      splashBloc: splashBloc,
    );
  }
}
