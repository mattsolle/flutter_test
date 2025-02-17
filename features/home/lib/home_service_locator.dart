import 'package:core/core.dart';

import 'src/bookmarks/data/models/bookmarks.dart';
import 'src/restaurants/data/repositories/restaurants_repository.dart';

Future<void> initServiceLocator() async {
  ////----- Restaurants -----//
  di.registerFactory<RestaurantsRepository>(
    () => RestaurantsRepositoryImpl(httpClient: di()),
  );

  ////----- Bookmarks -----//
  di.registerFactory<LocalRepository<Bookmarks>>(
    () => LocalRepositoryImpl<Bookmarks>(
      storage: di(),
      baseModel: Bookmarks.fromJson,
    ),
  );
}
