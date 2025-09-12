import 'package:dartz/dartz.dart';
import 'package:mobile_intern_test/core/error/exceptions.dart';
import 'package:mobile_intern_test/core/error/failures.dart';
import 'package:mobile_intern_test/core/helper/mapper/location_mapper.dart';
import 'package:mobile_intern_test/data/location/data_sources/location_service_data_source.dart';
import 'package:mobile_intern_test/di.dart';
import 'package:mobile_intern_test/domain/location/entities/location_entity.dart';
import 'package:mobile_intern_test/domain/location/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Either<Failure, List<LocationEntity>>> searchPlaces(
    String query,
  ) async {
    try {
      final result = await getIt<LocationServiceDataSource>().searchPlaces(
        query,
      );

      final data = result
          .map((model) => LocationMapper.toEntity(model))
          .toList();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error"));
    }
  }
}
