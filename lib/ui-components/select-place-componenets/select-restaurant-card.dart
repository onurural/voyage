import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voyage/bloc/restaurant/restaurant.bloc.dart';
import 'package:voyage/bloc/restaurant/restaurant.event.dart';
import 'package:voyage/bloc/restaurant/restaurant.state.dart';
import 'dart:math' as math;

import 'package:voyage/models/restaurants.dart';
import 'package:voyage/utility/min-price.enum.dart';

import '../../bloc/photos-fetcher/photos-fetcher-bloc.dart';
import '../../data/photos-fetcher.data.dart';
import '../schedule-screen-components/Activity.dart';
import 'InnerActivityCard.dart';

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
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  double _rotationAngle = 0;

  bool _selected = false;

  final RestaurantBloc _restaurantBloc = RestaurantBloc();

  @override
  void initState() {
    super.initState();
    _restaurantBloc.add(FetchRestaurant(city: widget.cityName, maxPrice: Price.four, minPrice: Price.zero));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(_animationController);
    _animationController.addListener(() {
      setState(() {
        _rotationAngle = _animationController.value * 2 * math.pi;
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
                Activity temp=Activity(beginTime: null, endTime: null, day: null, title: '${state.model[index].name}', category: 'Restaurant', rate: double.parse( '${state.model[index].rating}'), description: 'desc', photos: null, placeID: '${state.model[index].placeId}', duration: null);
                return  BlocProvider(create: (context) => PhotosFetcherBloc(data: PhotosFetcherData()),
                  child:  InnerActivityCard(temp,widget.addActivity,widget.removeActivity),
                );
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
