import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/entertainment/entertainment.bloc.dart';
import 'package:voyage/bloc/entertainment/entertainment.event.dart';
import 'package:voyage/bloc/entertainment/entertainment.state.dart';
import 'package:voyage/bloc/restaurant/restaurant.state.dart';
import 'dart:math' as math;

import 'package:voyage/models/entertainment.dart';
import 'package:voyage/utility/min-price.enum.dart';

class SelectEntertainmentCard extends StatefulWidget {
  String cityName;
  SelectEntertainmentCard(this.cityName, {super.key});

  @override
  State<SelectEntertainmentCard> createState() => _SelectEntertainmentCard();
}

class _SelectEntertainmentCard extends State<SelectEntertainmentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  double _rotationAngle = 0;

  bool _selected = false;

  final EntertainmentBloc _entertainmentBloc = EntertainmentBloc();

  @override
  void initState() {
    super.initState();
    _entertainmentBloc.add(FetchEntertainment(city: widget.cityName, minPrice: Price.zero, maxPrice: Price.four));
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
      create: (context) => _entertainmentBloc,
      child: BlocConsumer<EntertainmentBloc, EntertainmentState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EntertainmentLoadedState) {
            return entertainments(state); 
          }
          if (state is EntertainmentLoadingState) {
            return const CircularProgressIndicator();  
          }
          if (state is EntertainmentErrorState) {
            return const Text('Error');  
          }
          if (state is EntertainmentInitialState) {
            return const Text('Initital State');
          }
          return const Text('Unrecognized Error');
        },
      ),
    );
  }

  SizedBox entertainments(EntertainmentLoadedState state) {
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
