import 'package:voyage/models/place.dart';
import 'package:voyage/utility/category.enum.dart';

abstract class PlaceRepository {
  Future<List<Place>> fetchPlace();
  Future<List<Place>> fetchPlaceByCategory(CATEGORY category);
}