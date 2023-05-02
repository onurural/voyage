
import 'dart:ui' as ui;


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/place-components/description-box.dart';
import 'package:voyage/models/place.dart';



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

  @override
  void initState() {
    super.initState();

  }
bool isButtonShown=true;
  Widget buildStar(BuildContext context, int index) {
    IconData starIcon;
    var rating = widget.place.rating ?? -1;
    if (index <  rating) {
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
        decoration: widget.place.image != null ? BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(widget.place.image!.image!),
            fit: BoxFit.cover,
          ),
        ): null,
        child: GestureDetector(
          onTap:  (){
    setState(() {
    isButtonShown=false;
    });
    Navigator.pop(context);
    },
          child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.black.withOpacity(0.3)),
            ),
        ),
      ),
          Positioned(
            top: 50,
            left: 20,
            child: Visibility(visible: isButtonShown,child: IconButton(onPressed: (){
              setState(() {
                isButtonShown=false;
              });
              Navigator.pop(context);
            } , icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,)),)
          ),
      Center(
          child: Padding(
              padding:  const EdgeInsets.all(10),
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
                            offset:  const Offset(0, 2),
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
                                borderRadius:  const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                image: widget.place.image != null ? DecorationImage(
                                  image: MemoryImage(widget.place.image!.image!),
                                  fit: BoxFit.cover,
                                ): null,
                              ),
                              child: Padding(
                                padding:
                                     const EdgeInsets.fromLTRB(20, 300, 20, 0),
                                child: Column(
                                  children: [
                                    Container(
                                        padding:  const EdgeInsets.all(8),
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
                                        child: Text(widget.place.name ?? 'null',
                                            style:  const TextStyle(
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
                                borderRadius:  const BorderRadius.only(
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
                          padding:  const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:  1, // TODO: Fetch more image from API
                              itemBuilder: (context, index) {
                                index = index + 1;
                                return Padding(
                                  padding:
                                       const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // photoSelected =
                                        //     widget.place.image;
                                      });
                                    },
                                     child: Image.memory(widget.place.image!.image!)
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
                                          textStyle:  const TextStyle(
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
                                secondChild: DescriptionBox(widget.place.reviews?[0].text ?? 'null'), // TODO Wrap with Listview.builder and return AnimatedCrossFade then change '[0]' with index property
                                crossFadeState: isDescShowed
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration:  const Duration(milliseconds: 500),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration:  const BoxDecoration(
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
                                      textStyle:  const TextStyle(
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
