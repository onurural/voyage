abstract class PlaceToTravelEvent {}

class FetchPlaceToTravel extends PlaceToTravelEvent {
  late String city;
  FetchPlaceToTravel(this.city);
}