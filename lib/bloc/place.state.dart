import 'package:voyage/models/place.dart';

abstract class PlaceState {}



class PlaceInitialState extends PlaceState {}
class PlaceLoadingState extends PlaceState {}
class PlaceLoadedState extends PlaceState {
  final List<Place> model;
  PlaceLoadedState(this.model);
}
class PlaceErrorState extends PlaceState {}