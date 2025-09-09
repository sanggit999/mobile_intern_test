class LocationModel {
  final String displayName;
  final double lat;
  final double lon;

  LocationModel({
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      displayName: json['display_name'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}
