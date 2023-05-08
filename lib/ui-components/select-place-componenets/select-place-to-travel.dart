import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:voyage/bloc/places-to-travel/place-to-travel.bloc.dart';
import 'package:voyage/bloc/places-to-travel/place-to-travel.event.dart';
import 'package:voyage/bloc/places-to-travel/place-to-travel.state.dart';

class SelectPlaceToTravelCard extends StatefulWidget {
  String cityName;
  SelectPlaceToTravelCard(this.cityName, {super.key});

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
            return const CircularProgressIndicator();  
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
          return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 250,
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 250 / 300,
                      child: Stack(children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/Images/1.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 20, 15, 0),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.model[index].name}',
                                    style: GoogleFonts.notoSerif(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RatingBarIndicator(
                                        rating: 2.5,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                        ),
                                        itemCount: 5,
                                        itemSize: 15,
                                        direction: Axis.horizontal,
                                      ),
                                      Text(
                                        '${state.model[index].rating}',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 0, 15, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        !_selected
                                            ? 'Add To Your Schedule'
                                            : 'Selected',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selected = !_selected;
                                      });
                                      if (_selected) {
                                        _animationController.forward();
                                      } else {
                                        _animationController.reverse();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 8, 8, 8),
                                      decoration: BoxDecoration(
                                        color: _colorAnimation.value,
                                        borderRadius:
                                            BorderRadius.circular(5),
                                      ),
                                      child: AnimatedBuilder(
                                        animation: _colorAnimation,
                                        builder: (context, child) {
                                          return Transform.rotate(
                                            angle: _rotationAngle,
                                            child: Icon(
                                              Icons.add_box_outlined,
                                              color: _selected
                                                  ? Color.fromRGBO(
                                                      37, 154, 180, 100)
                                                  : Colors.white,
                                              size: 25,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ));
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
