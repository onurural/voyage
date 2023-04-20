

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/place/place.event.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'package:voyage/data/place.data.dart';
import 'package:voyage/models/place.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceData placeData;
  PlaceBloc(this.placeData): super(PlaceInitialState()) {
    on<PlaceEvent>((event, emit) async {
      if (event is FetchPlace) {
        emit(PlaceLoadingState());
        List<Place> places = await placeData.fetchPlace();
        emit(PlaceLoadedState(places));
      }
      if (event is FetchHistoricPlace) {
        emit(PlaceLoadingState());
        List<Place> places = await placeData.fetchPlace();
        emit(PlaceLoadedState(places));
      }
    });
  }

}