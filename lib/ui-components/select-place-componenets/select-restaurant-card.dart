import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
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
            return ListView.builder(
                itemCount: 5, // Set the number of shimmer cards here
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 250.0, // Adjust the width to match your card

                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  );
                });
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
                Activity temp=Activity(beginTime: null, endTime: null, day: null, title: '${state.model[index].name}', category: 'Restaurant', rate: double.parse( '${state.model[index].rating}'), description: 'desc', photos: [], placeID: '${state.model[index].placeId}', duration: null, photosLinks: []);
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
