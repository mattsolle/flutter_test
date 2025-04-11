import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'domain/datasources/restaurant_datasource.dart';
import 'domain/repositories/restaurant_repository.dart';
import 'domain/services/authorization_service.dart';
import 'domain/use_cases/get_restaurant_details_use_case.dart';
import 'domain/use_cases/get_restaurants_use_case.dart';
import 'external/datasources/restaurant_datasource_impl.dart';
import 'external/interceptors/dio_authorization_interceptor.dart';
import 'external/interceptors/dio_request_caching_interceptor.dart';
import 'external/repositories/restaurant_repository_impl.dart';
import 'external/use_cases/get_restaurant_use_case_impl.dart';
import 'external/use_cases/get_restaurants_use_case_impl.dart';

GetIt setup() {
  final i = GetIt.asNewInstance();

  final dio = Dio();

  final authorization = DioAuthorizationInterceptor();
  final cachingInterceptor = DioRequestCachingInterceptor();

  dio.interceptors.add(authorization);
  dio.interceptors.add(cachingInterceptor);

  i.registerSingleton(dio);

  i.registerSingleton<AuthorizationService>(
    authorization,
  );

  i.registerFactory<RestaurantDatasource>(() => RestaurantDatasourceImpl(dio));

  i.registerFactory<RestaurantRepository>(
    () => RestaurantRepositoryImpl(i.get()),
  );

  i.registerFactory<GetRestaurantsUseCase>(
    () => GetRestaurantsUseCaseImpl(i.get()),
  );

  i.registerFactory<GetRestaurantDetailsUseCase>(
    () => GetRestaurantDetailsUseCaseImpl(i.get()),
  );

  return i;
}
