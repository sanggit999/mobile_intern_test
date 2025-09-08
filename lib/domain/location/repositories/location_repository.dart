import 'package:dartz/dartz.dart';
import 'package:mobile_intern_test/core/error/failure.dart';
import 'package:mobile_intern_test/domain/location/entities/location_entity.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<LocationEntity>>> searchPlaces(String query);
}
