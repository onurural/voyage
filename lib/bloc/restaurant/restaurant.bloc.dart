
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/restaurant/restaurant.event.dart';
import 'package:voyage/bloc/restaurant/restaurant.state.dart';
import 'package:voyage/data/activity.data.dart';
import 'package:voyage/models/restaurants.dart';
import 'package:voyage/repository/activity.repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final ActivityRepository placeData = ActivityData();
  RestaurantBloc(): super(RestaurantInitialState()) {
    on<RestaurantEvent>((event, emit) async {
      if (event is FetchRestaurant) {
        try {
            emit(RestaurantLoadingState());
            List<Restaurant> places = await placeData.findRestaurants(city: event.city, maxPrice: event.maxPrice, minPrice: event.minPrice);
            emit(RestaurantLoadedState(places));
        } catch (e) {
            emit(RestaurantErrorState(e.toString()));
        }

      }
    });
  }

}