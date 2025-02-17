import 'package:core/core.dart';

import 'src/restaurants/data/repositories/restaurants_repository.dart';

Future<void> initServiceLocator() async {
  di.registerFactory<RestaurantsRepository>(
    () => RestaurantsRepositoryImpl(httpClient: di()),
  );
}
