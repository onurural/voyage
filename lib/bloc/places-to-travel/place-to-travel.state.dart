import 'package:voyage/models/place-to-travel.dart';

abstract class PlaceToTravelState {}



class PlaceToTravelInitialState extends PlaceToTravelState {}
class PlaceToTravelLoadingState extends PlaceToTravelState {}
class PlaceToTravelLoadedState extends PlaceToTravelState {
  final List<PlaceToTravel> model;
  PlaceToTravelLoadedState(this.model);
}
class PlaceToTravelErrorState extends PlaceToTravelState {
  final String errorMessage;
  PlaceToTravelErrorState(this.errorMessage);
}