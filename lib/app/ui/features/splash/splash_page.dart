import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../app/app_router.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_bloc_events.dart';
import 'bloc/splash_bloc_states.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.splashBloc});

  final SplashBloc splashBloc;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc get bloc => widget.splashBloc;

  late StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    subscription = bloc.stream.listen(onState);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        init();
      },
    );
  }

  void onState(SplashBlocState state) {
    if (state is SplashSuccessState && mounted) {
      context.go(AppRouter.home);
    }
  }

  void init() {
    bloc.add(const SplashInitEvent());
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashBlocState>(
      bloc: bloc,
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
