sealed class SplashBlocState {
  const SplashBlocState();
}

final class SplashLoadingState extends SplashBlocState {
  const SplashLoadingState();
}

final class SplashSuccessState extends SplashBlocState {
  const SplashSuccessState();
}

final class SplashErrorState extends SplashBlocState {
  const SplashErrorState();
}
