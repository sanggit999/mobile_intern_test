import 'package:dartz/dartz.dart';
import 'package:mobile_intern_test/core/error/failure.dart';
import 'package:mobile_intern_test/data/location/data_sources/location_service_repository.dart';
import 'package:mobile_intern_test/di.dart';
import 'package:mobile_intern_test/domain/location/entities/location_entity.dart';
import 'package:mobile_intern_test/domain/location/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Either<Failure, List<LocationEntity>>> searchPlaces(
    String query,
  ) async {
    final result = await getIt<LocationServiceRepository>().searchPlaces(query);
    return result.fold(
      (error) {
        return Left(ServerFailure(message: error.message));
      },
      (data) {
        return Right(data);
      },
    );
  }
}
