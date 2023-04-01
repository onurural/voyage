import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/place-components/hero_dialog_route.dart';
import 'package:voyage/views/place.view.dart';
import 'package:voyage/models/place.dart';

class PlaceBigCard extends StatefulWidget {
  final Place place;
  final String globlaId;

  PlaceBigCard(this.place, this.globlaId, {super.key});

  @override
  State<PlaceBigCard> createState() => _PlaceBigCardState();
}

class _PlaceBigCardState extends State<PlaceBigCard> {
  var globalId;

  String generateRandomString(int length) {
    final rand = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const charLength = chars.length;
    String result = '';
    for (var i = 0; i < length; i++) {
      result += chars[rand.nextInt(charLength)];
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    globalId = generateRandomString(5);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        width: double.infinity,
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
          image: DecorationImage(
            image: MemoryImage(Image.memory(base64Decode(widget.place.image?.image ?? '')) as Uint8List),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25),
              BlendMode.darken,
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.75),
                        Colors.black.withOpacity(0.0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.place.name ?? 'nil',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: widget.place.rating ?? -1,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20,
                          direction: Axis.horizontal,
                        ),
                        Text(
                          widget.place.rating.toString(),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            HeroDialogRoute(
                              builder: (context) =>
                                  PlaceScreen(widget.place, widget.globlaId),
                              settings: const RouteSettings(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: Hero(
                          tag: widget.globlaId,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Read More',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
