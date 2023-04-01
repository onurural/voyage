
import 'package:flutter/material.dart';

import '../ui-components/home-view-components/place-small-card.dart';

class ShowMoreScreen extends StatelessWidget {
 late List<PlaceSmallCard> places;
 late var hero;

  ShowMoreScreen(this.places, this.hero, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.all(10),
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
                      child: Column(children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: ListView.builder(
                            itemCount: places.length,
                            itemBuilder: (context, index) {
                              return PlaceSmallCard(
                                  places[index].place,
                                  hero);
                            },
                          ),
                        ),
                      ]))))
        ]));
  }
}
