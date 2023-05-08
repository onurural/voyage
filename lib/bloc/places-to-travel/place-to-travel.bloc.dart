
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/places-to-travel/place-to-travel.event.dart';
import 'package:voyage/bloc/places-to-travel/place-to-travel.state.dart';
import 'package:voyage/data/activity.data.dart';
import 'package:voyage/models/place-to-travel.dart';
import 'package:voyage/repository/activity.repository.dart';

class PlaceToTravelBloc extends Bloc<PlaceToTravelEvent, PlaceToTravelState> {
  final ActivityRepository placeData = ActivityData();
  PlaceToTravelBloc(): super(PlaceToTravelInitialState()) {
    on<PlaceToTravelEvent>((event, emit) async {
      if (event is FetchPlaceToTravel) {
        try{
            emit(PlaceToTravelLoadingState());
            List<PlaceToTravel> places = await placeData.findPlaceToTravel(city:event.city);
            emit(PlaceToTravelLoadedState(places));
        } catch(e) {
          emit(PlaceToTravelErrorState(e.toString()));
        } 
      }
    });
  }
}