import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

import 'Place.dart';

class PlaceSmallCard extends StatefulWidget {
  final Place place;


  const PlaceSmallCard(this.place, {super.key});

  @override
  State<PlaceSmallCard> createState() => _PlaceSmallCardState();
}

class _PlaceSmallCardState extends State<PlaceSmallCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        width:250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          // image: Image.memory(base64Decode('dfasfdas'))
          ),
          child: Image.memory(base64Decode(widget.place.image?.image ?? '')),

        ),
),

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0,0 ),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(widget.place.name ?? '',style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              letterSpacing: 1
                            )
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBarIndicator(
                                rating: widget.place.rating ?? 0,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.radio_button_checked,
                                  color: Colors.black,
                                ),
                                itemCount: 5,
                                itemSize: 15,
                                direction: Axis.horizontal,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0,  0),
                                child: Text(widget.place.rating.toString(),style:
                                  GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black
                                    )
                                  ),),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: MaterialButton(onPressed: () {  },
                          child: Text(
                            'Read More',style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
