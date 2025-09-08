import 'package:dartz/dartz.dart';
import 'package:mobile_intern_test/core/error/failure.dart';
import 'package:mobile_intern_test/core/usecase/usecase.dart';
import 'package:mobile_intern_test/di.dart';
import 'package:mobile_intern_test/domain/location/entities/location_entity.dart';
import 'package:mobile_intern_test/domain/location/repositories/location_repository.dart';

class SearchPlacesUseCase
    implements UseCase<Either<Failure, List<LocationEntity>>, String> {
  @override
  Future<Either<Failure, List<LocationEntity>>> call(String params) {
    return getIt<LocationRepository>().searchPlaces(params);
  }
}
