
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/place/place.event.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'package:voyage/category.enum.dart';
import 'package:voyage/data/place.data.dart';
import 'package:voyage/models/place.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceData placeData = PlaceData();
  PlaceBloc(): super(PlaceInitialState()) {
    on<PlaceEvent>((event, emit) async {
      if (event is FetchPlace) {
        emit(PlaceLoadingState());
        List<Place> places = await placeData.fetchPlace();
        emit(PlaceLoadedState(places));
      }
      if (event is FetchHistoricPlace) {
        emit(PlaceLoadingState());
        List<Place> places = await placeData.fetchPlaceByCategory(CATEGORY.historic);
        emit(PlaceLoadedState(places));
      }
      if (event is FetchNaturalPlace) {
        emit(PlaceLoadingState());
        List<Place> places = await placeData.fetchPlaceByCategory(CATEGORY.natural);
        emit(PlaceLoadedState(places));
      }
      if (event is FetchCityVibesPlace) {
        emit(PlaceLoadingState());
        List<Place> places = await placeData.fetchPlaceByCategory(CATEGORY.cityVibes);
        emit(PlaceLoadedState(places));
      }
      if (event is FetchMediterrainPlace) {
        emit(PlaceLoadingState());
        List<Place> places = await placeData.fetchPlaceByCategory(CATEGORY.mediterrain);
        emit(PlaceLoadedState(places));
      }
      if (event is FetchRuralPlace) {
        emit(PlaceLoadingState());
        List<Place> places = await placeData.fetchPlaceByCategory(CATEGORY.rural);
        emit(PlaceLoadedState(places));
      }
    });
  }

}