import 'package:dartz/dartz.dart';
import 'package:mobile_intern_test/core/error/failure.dart';
import 'package:mobile_intern_test/core/helper/mapper/location_mapper.dart';
import 'package:mobile_intern_test/core/network/api_client.dart';
import 'package:mobile_intern_test/data/location/models/location_model.dart';
import 'package:mobile_intern_test/di.dart';
import 'package:mobile_intern_test/domain/location/entities/location_entity.dart';

abstract class LocationServiceRepository {
  Future<Either<Failure, List<LocationEntity>>> searchPlaces(String query);
}

class LocationServiceRepositoryImpl implements LocationServiceRepository {
  @override
  Future<Either<Failure, List<LocationEntity>>> searchPlaces(
    String query,
  ) async {
    try {
      var response = await getIt<ApiClient>().searchPlacesRaw(query);

      final locations = response.map<LocationEntity>((item) {
        LocationModel locationModel = LocationModel(
          displayName: item['display_name'] ?? '',
          lat: double.tryParse(item['lat'] ?? '') ?? 0.0,
          lon: double.tryParse(item['lon'] ?? '') ?? 0.0,
        );
        return LocationMapper.toEntity(locationModel);
      }).toList();

      return Right(locations);
    } catch (e) {
      if (e.toString().contains("Rate Limited")) {
        return Left(ServerFailure(message: "rate-limited"));
      }
      return Left(ServerFailure(message: "not-found"));
    }
  }
}
