abstract class CityEvent {}

class FetchCities extends CityEvent {
  final String query;

  FetchCities(this.query);
}