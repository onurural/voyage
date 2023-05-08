import 'package:voyage/models/restaurants.dart';

abstract class RestaurantState {}

class RestaurantInitialState extends RestaurantState {}
class RestaurantLoadingState extends RestaurantState {}
class RestaurantLoadedState extends RestaurantState {
  final List<Restaurant> model;
  RestaurantLoadedState(this.model);
}
class RestaurantErrorState extends RestaurantState {
  final String errorMessage;
  RestaurantErrorState(this.errorMessage);
}