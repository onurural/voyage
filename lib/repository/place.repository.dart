import 'package:voyage/models/place.dart';

abstract class PlaceRepository {
  Future<List<Place>> fetchPlace();
  Future<List<Place>> fetchPlaceByCategory(String category);
}

