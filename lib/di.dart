import 'package:get_it/get_it.dart';
import 'package:mobile_intern_test/core/network/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_intern_test/data/location/data_sources/location_service_data_source.dart';
import 'package:mobile_intern_test/data/location/repositories_impl/location_repository_impl.dart';
import 'package:mobile_intern_test/domain/location/repositories/location_repository.dart';
import 'package:mobile_intern_test/domain/location/usecases/search_places_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Client
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(http.Client()));

  //Service
  getIt.registerLazySingleton<LocationServiceDataSource>(
    () => LocationServiceDataSourceImpl(),
  );

  //Repository
  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(),
  );

  //Usecase
  getIt.registerLazySingleton<SearchPlacesUseCase>(() => SearchPlacesUseCase());
}
