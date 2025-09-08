import 'package:mobile_intern_test/domain/location/entities/location_entity.dart';

abstract class SearchPlacesState {}

class SearchPlacesInitial extends SearchPlacesState {}

class SearchPlacesLoading extends SearchPlacesState {}

class SearchPlacesLoaded extends SearchPlacesState {
  final List<LocationEntity> locationEntity;

  SearchPlacesLoaded({required this.locationEntity});
}

class SearchPlacesError extends SearchPlacesState {
  final String message;

  SearchPlacesError({required this.message});
}
