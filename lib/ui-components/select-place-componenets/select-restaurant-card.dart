import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/restaurant/restaurant.bloc.dart';
import 'package:voyage/bloc/restaurant/restaurant.event.dart';
import 'package:voyage/bloc/restaurant/restaurant.state.dart';
import 'package:voyage/models/activity.dart';
import 'dart:math' as math;
import 'package:voyage/utility/min-price.enum.dart';
import 'inner-restaurant-card.dart';

class SelectRestaurantCard extends StatefulWidget {
  String cityName;

  final Function(Activity) addActivity;
  final Function(Activity) removeActivity;


  SelectRestaurantCard(this.cityName, this.addActivity, this.removeActivity);

  @override
  State<SelectRestaurantCard> createState() => _SelectRestaurantCard();
}

class _SelectRestaurantCard extends State<SelectRestaurantCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;


  final RestaurantBloc _restaurantBloc = RestaurantBloc();

  @override
  void initState() {
    super.initState();
    _restaurantBloc.add(FetchRestaurant(city: widget.cityName, maxPrice: Price.four, minPrice: Price.zero));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _restaurantBloc,
      child: BlocConsumer<RestaurantBloc, RestaurantState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is RestaurantLoadedState) {
            return _restaurants(state);
          }
           if (state is RestaurantLoadingState) {
            return Container();
          }
          if (state is RestaurantErrorState) {
            return const Text('Error');  
          }
          if (state is RestaurantInitialState) {
            return const Text('Initital State');
          }
          return const Text('Unrecognized Error');
        },
      ),
    );
  }


SizedBox _restaurants(RestaurantLoadedState state) {
  return SizedBox(
    height: 300,
    width: double.maxFinite,
    child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.model.length,
              itemBuilder: (context, index) {
                Activity temp=Activity(beginTime: null, endTime: null, day: null, title: '${state.model[index].name}', category: 'Restaurant', rate: double.parse( '${state.model[index].rating}'), description: 'desc', photos: state.model[index].photos, placeID: '${state.model[index].placeId}', duration: null);
                return  InnerRestaurantActivityCard(state.model[index], temp,widget.addActivity,widget.removeActivity);
              },
            ),
  );
}
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
