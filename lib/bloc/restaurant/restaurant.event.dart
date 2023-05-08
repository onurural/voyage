import 'package:voyage/utility/min-price.enum.dart';
abstract class RestaurantEvent {}

class FetchRestaurant extends RestaurantEvent {
  late String city;
  late Price minPrice;
  late Price maxPrice;
  
  FetchRestaurant({required this.city, required this.maxPrice, required this.minPrice});
}

