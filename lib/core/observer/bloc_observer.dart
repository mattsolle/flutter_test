import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  final AppLogger logger;

  AppBlocObserver({required this.logger});

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.logInfo('Bloc Created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.logInfo('Bloc Event: ${bloc.runtimeType} -> $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.logInfo('Bloc Change: ${bloc.runtimeType} -> $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.logInfo('Bloc Transition: ${bloc.runtimeType} -> $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.logError(
      'Bloc Error in ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.logInfo('Bloc Closed: ${bloc.runtimeType}');
  }
}
