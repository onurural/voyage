import 'package:flutter/material.dart';

class PlaceCardView extends StatelessWidget {
  final String title;


   const PlaceCardView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
     return Center(
        child: Card(
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(child: Text(title)),
          ),
        ),
      );
  }
}


     