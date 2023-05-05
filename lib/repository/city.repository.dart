 import '../models/autocomplete-prediction.dart';

abstract class CityRepository {
  Future<List<Predictions>?> fetchCities(String query);
}