import 'package:mobile_intern_test/core/error/exceptions.dart';
import 'package:mobile_intern_test/core/network/api_client.dart';
import 'package:mobile_intern_test/data/location/models/location_model.dart';
import 'package:mobile_intern_test/di.dart';

abstract class LocationServiceDataSource {
  Future<List<LocationModel>> searchPlaces(String query);
}

class LocationServiceDataSourceImpl implements LocationServiceDataSource {
  @override
  Future<List<LocationModel>> searchPlaces(String query) async {
    try {
      final response = await getIt<ApiClient>().searchPlacesRaw(query);

      if (response.isEmpty) {
        throw ServerException(message: "not-found");
      }
      final locations = response
          .map((item) => LocationModel.fromJson(item))
          .toList();

      return locations;
    } catch (e) {
      if (e.toString().contains("Rate Limited")) {
        throw (ServerException(message: "rate-limited"));
      }
      throw ServerException(message: "not-found");
    }
  }
}
