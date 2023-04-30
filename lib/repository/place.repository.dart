import 'package:voyage/utility/category.enum.dart';
import 'package:voyage/models/place.dart';
import 'package:voyage/utility/page.enum.dart';

abstract class PlaceRepository {
  Future<List<Place>> fetchPlace(Page pageNumber);
  Future<List<Place>> fetchPlaceByCategory(CATEGORY category,  Page pageNumber);
}

