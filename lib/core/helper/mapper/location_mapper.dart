import 'package:mobile_intern_test/data/location/models/location_model.dart';
import 'package:mobile_intern_test/domain/location/entities/location_entity.dart';

class LocationMapper {
  LocationMapper._();

  static LocationEntity toEntity(LocationModel locationModel) {
    return LocationEntity(
      displayName: locationModel.displayName,
      lat: locationModel.lat,
      lon: locationModel.lon,
    );
  }
}
