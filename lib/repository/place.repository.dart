import 'package:voyage/category.enum.dart';
import 'package:voyage/models/place.dart';

abstract class PlaceRepository {
  Future<List<Place>> fetchPlace();
  Future<List<Place>> fetchPlaceByCategory(CATEGORY category);
}