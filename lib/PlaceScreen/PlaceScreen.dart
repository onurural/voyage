import 'dart:ui' as ui;


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/PlaceScreen/DescriptionBox.dart';

import '../Home/Place.dart';


class PlaceScreen extends StatefulWidget {
  final Place place;
  final String hero;


  const PlaceScreen(this.place, this.hero, {super.key});

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  var buttonIcon = Icons.arrow_downward_rounded;
  var isDescShowed = false;
  var photoSelected;

  @override
  void initState() {
    super.initState();
    photoSelected = widget.place.images.first;
  }

  Widget buildStar(BuildContext context, int index) {
    IconData starIcon;
    if (index < widget.place.rate) {
      starIcon = Icons.star;
    } else {
      starIcon = Icons.star_border;
    }
    return Icon(
      starIcon,
      color: Colors.yellow.shade700,
      size: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(photoSelected),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
      ),
      Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Hero(
                  tag: widget.hero,

                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                image: DecorationImage(
                                  image: AssetImage(photoSelected),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 300, 20, 0),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.black.withOpacity(0.7),
                                              Colors.black.withOpacity(0.5),
                                            ],
                                          ),
                                        ),
                                        child: Text(widget.place.title,
                                            style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              decoration: TextDecoration.none
                                             ),)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.place.images.length - 1,
                              itemBuilder: (context, index) {
                                index = index + 1;
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        photoSelected =
                                            widget.place.images[index];
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              widget.place.images[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          child: Column(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    isDescShowed = !isDescShowed;
                                    if (isDescShowed == false) {
                                      buttonIcon =
                                          Icons.arrow_downward_rounded;
                                    } else {
                                      buttonIcon = Icons.arrow_upward_rounded;
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Description',
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    Icon(
                                      buttonIcon,
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              AnimatedCrossFade(
                                firstChild: Container(),
                                secondChild: DescriptionBox(widget.place.desc),
                                crossFadeState: isDescShowed
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 500),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                          ),
                         
                          child: MaterialButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Create your own schedule',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                ),
                                const Icon(
                                  Icons.schedule,
                                  color: Colors.white,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                        )
                      ]))))))
    ]));
  }
}
