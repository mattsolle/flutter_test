import 'package:bloc/bloc.dart';

import '../../../../domain/architecture/constants.dart';
import '../../../../domain/services/authorization_service.dart';
import '../../../utils/extensions/int_extension.dart';
import 'splash_bloc_events.dart';
import 'splash_bloc_states.dart';

class SplashBloc extends Bloc<SplashBlocEvents, SplashBlocState> {
  SplashBloc(this.service) : super(const SplashLoadingState()) {
    on<SplashInitEvent>(init);
  }

  final AuthorizationService service;

  Future<void> init(SplashInitEvent event, Emitter emit) async {
    try {
      service.setBearer(Constants.apiKey);
      await Future.delayed(1.second);
      emit(const SplashSuccessState());
    } catch (e) {
      emit(const SplashErrorState());
      rethrow;
    }
  }
}
