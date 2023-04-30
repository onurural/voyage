
// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionBox extends StatefulWidget {
  String text;


  DescriptionBox(this.text, {super.key});

  @override
  State<DescriptionBox> createState() => _DescriptionBoxState();
}

class _DescriptionBoxState extends State<DescriptionBox> {
  @override
  Widget build(BuildContext context) {
    return
       SizedBox(
        width: double.infinity,
        height: 200,
        child: Padding(
          padding:  const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(widget.text,style:
                GoogleFonts.poppins(
                  textStyle:  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                  ),
                  decoration: TextDecoration.none
                ),
              )
            ],


          ),
        ),

    );
  }
}
