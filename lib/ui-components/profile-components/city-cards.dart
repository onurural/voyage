
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CityCards extends StatelessWidget {
  final List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
// Add more city names here
  ];

   CityCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: cities.map((city) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(44, 87, 116, 100),
              Colors.grey
            ]),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(city,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ))),
        );
      }).toList(),
    );
  }
}