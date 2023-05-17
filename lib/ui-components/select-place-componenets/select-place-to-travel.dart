import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;

import 'package:voyage/bloc/places-to-travel/place-to-travel.bloc.dart';
import 'package:voyage/bloc/places-to-travel/place-to-travel.event.dart';
import 'package:voyage/bloc/places-to-travel/place-to-travel.state.dart';
import 'package:voyage/models/activity.dart';
import 'package:voyage/ui-components/select-place-componenets/inner-place-to-travel-card.dart';

class SelectPlaceToTravelCard extends StatefulWidget {
  String cityName;

  final Function(Activity) addActivity;
  final Function(Activity) removeActivity;


  SelectPlaceToTravelCard(this.cityName, this.addActivity, this.removeActivity);

  @override
  State<SelectPlaceToTravelCard> createState() => _SelectPlaceToTravelCard();
}

class _SelectPlaceToTravelCard extends State<SelectPlaceToTravelCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  double _rotationAngle = 0;
  final PlaceToTravelBloc _placeToTravelBloc = PlaceToTravelBloc();
  bool _selected = false;

  @override
  void initState() {
    super.initState();
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
    _placeToTravelBloc.add(FetchPlaceToTravel(widget.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _placeToTravelBloc,
      child: BlocConsumer<PlaceToTravelBloc, PlaceToTravelState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PlaceToTravelLoadedState) {
            return _placesToTravel(state);  
          }
          if (state is PlaceToTravelLoadingState) {
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
          if (state is PlaceToTravelErrorState) {
            return const Text('Error');  
          }
          if (state is PlaceToTravelInitialState) {
            return const Text('Initital State');
          }
          return const Text('Unrecognized Error');
        },
      ),
    );
  }

  SizedBox _placesToTravel(PlaceToTravelLoadedState state) {
    return SizedBox( 
      height: 300,
      width: double.maxFinite,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.model.length,
        itemBuilder: (context, index) {
          Activity temp=Activity(beginTime: null, endTime: null, day: null, title: '${state.model[index].name}', category: 'Must To See', rate: double.parse( '${state.model[index].rating}'), description: 'desc', photos: [], placeID: '${state.model[index].placeId}', duration: null, photosLinks: []);
          return  InnerPlaceToTravelActivityCard(state.model[index], temp,widget.addActivity,widget.removeActivity);
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
