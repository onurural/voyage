import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedItem extends StatefulWidget {
  String title;

  final Function(int) onRestore;
  int index;


  CompletedItem(this.title, this.onRestore, this.index);

  @override
  State<CompletedItem> createState() => _CompletedItemState();
}

class _CompletedItemState extends State<CompletedItem> {
  @override
  Widget build(BuildContext context) {

    double fontSize = 14;

    return MaterialButton(
      onPressed: () {
        widget.onRestore(widget.index);
      },
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
         color: Color.fromRGBO( 44, 87, 116, 100),

        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Text(
          widget.title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
