import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voyage/bloc/photos-fetcher/photos-fetcher-event.dart';
import 'package:voyage/models/activity.dart';
import 'package:voyage/models/entertainment.dart';
import 'dart:math' as math;

import '../../bloc/photos-fetcher/photos-fetcher-bloc.dart';
import '../../bloc/photos-fetcher/photos-fetcher-state.dart';
import '../../data/photos-fetcher.data.dart';
import '../../models/photos.dart';



class InnerEntertainmentActivityCard extends StatefulWidget {
  Entertainment entertainment;
  Activity activity;
  final Function(Activity) addActivity;
  final Function(Activity) removeActivity;

  InnerEntertainmentActivityCard(this.entertainment, this.activity, this.addActivity, this.removeActivity);

  @override
  State<InnerEntertainmentActivityCard> createState() => _InnerActivityCardState();
}

class _InnerActivityCardState extends State<InnerEntertainmentActivityCard>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late AnimationController _animationController;
  var photosFetcher=PhotosFetcherBloc(data: PhotosFetcherData());

  double _rotationAngle = 0;

  bool _selected = false;

  @override
  void initState() {

    super.initState();
    photosFetcher.add(FetchImages(widget.activity.placeID!));
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
        create: (_) => photosFetcher,
        child: BlocConsumer<PhotosFetcherBloc, PhotosFetchersState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PhotosFetcherLoaded) {

                  for (var element in state.images) {
                    if(element.isNotEmpty){
                      widget.activity.photosLinks.add(element);
                    }
                  }
                  if(widget.activity.photosLinks.isNotEmpty){
                    return buildInnerActivityCard(context);
                  }
                  else{
                    return Container();
                  }
              }
              if (state is PhotosFetcherLoading) {

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
              }
              if (state is PhotosFetcherError) {
                return Container();
              }return Container(); } )
    );
  }


  Widget buildInnerActivityCard(BuildContext context) {
    var photoReference = widget.entertainment.photos?[0].photoReference;
    var apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:  NetworkImage(widget.activity.photosLinks.first),
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
                  // The rest of your UI elements go here
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.activity.title!,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBarIndicator(
                                  rating: 2.5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15,
                                  direction: Axis.horizontal,
                                ),
                                Text(
                                  widget.activity.rate!.toString(),
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  widget.addActivity(widget.activity);
                                  _animationController.forward();
                                } else {
                                  widget.removeActivity(widget.activity);
                                  _animationController.reverse();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                decoration: BoxDecoration(
                                  color: _colorAnimation.value,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: AnimatedBuilder(
                                  animation: _colorAnimation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _rotationAngle,
                                      child: Icon(
                                        Icons.add_box_outlined,
                                        color: _selected
                                            ? const Color.fromRGBO(37, 154, 180, 100)
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
