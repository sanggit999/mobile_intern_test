import 'package:dartz/dartz.dart';
import 'package:mobile_intern_test/core/error/failure.dart';
import 'package:mobile_intern_test/core/helper/mapper/location_mapper.dart';
import 'package:mobile_intern_test/core/network/api_client.dart';
import 'package:mobile_intern_test/data/location/models/location_model.dart';
import 'package:mobile_intern_test/di.dart';
import 'package:mobile_intern_test/domain/location/entities/location_entity.dart';

abstract class LocationServiceDataSource {
  Future<Either<Failure, List<LocationEntity>>> searchPlaces(String query);
}

class LocationServiceDataSourceImpl implements LocationServiceDataSource {
  @override
  Future<Either<Failure, List<LocationEntity>>> searchPlaces(
    String query,
  ) async {
    try {
      final response = await getIt<ApiClient>().searchPlacesRaw(query);

      final locations = response
          .map((item) => LocationModel.fromJson(item))
          .map((model) => LocationMapper.toEntity(model))
          .toList();

      return Right(locations);
    } catch (e) {
      if (e.toString().contains("Rate Limited")) {
        return Left(ServerFailure(message: "rate-limited"));
      }
      return Left(ServerFailure(message: "not-found"));
    }
  }
}
