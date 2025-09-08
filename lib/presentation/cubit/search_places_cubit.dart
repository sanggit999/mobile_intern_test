import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_intern_test/di.dart';
import 'package:mobile_intern_test/domain/location/usecases/search_places_usecase.dart';
import 'package:mobile_intern_test/presentation/cubit/search_places_state.dart';

class SearchPlacesCubit extends Cubit<SearchPlacesState> {
  SearchPlacesCubit() : super(SearchPlacesInitial());

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    emit(SearchPlacesLoading());

    final result = await getIt<SearchPlacesUseCase>().call(query);
    result.fold(
      (error) {
        emit(SearchPlacesError(message: error.message));
      },
      (data) {
        emit(SearchPlacesLoaded(locationEntity: data));
      },
    );
  }
}
