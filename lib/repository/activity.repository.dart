import 'package:voyage/models/entertainment.dart';
import 'package:voyage/models/place-to-travel.dart';
import 'package:voyage/models/restaurants.dart';
import 'package:voyage/utility/min-price.enum.dart';

abstract class ActivityRepository {
  Future<List<PlaceToTravel>> findPlaceToTravel({required String city});
  Future<List<Restaurant>> findRestaurants({required String city, required Price minPrice, required Price maxPrice});
  Future<List<Entertainment>> findEntertainment({required String city, required Price minPrice, required Price maxPrice});
}