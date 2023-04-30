import 'package:flutter/material.dart';

class CountryCardView extends StatelessWidget {
   const CountryCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Country Card')),
        ),
      ),
    );
  }
}