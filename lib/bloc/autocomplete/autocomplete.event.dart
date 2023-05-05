abstract class AutocompleteEvent {}

class FetchCities extends AutocompleteEvent {
  final String query;

  FetchCities(this.query);
}