

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/home-view-components/category.dart';


class CategoryCard extends StatefulWidget {
 final Category category;


 const CategoryCard(this.category, {super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isListViewed=false;





  @override
  Widget build(BuildContext context) {
    return Tab(
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(widget.category.title,style:
           GoogleFonts.poppins(
             textStyle: const TextStyle(color: Colors.black,
               fontSize: 20,
               fontWeight: FontWeight.w700
             )
           ),),
         Padding(
           padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
           child: Icon(widget.category.icon,color: Colors.black,),
         )
       ],
     ),

    );
  }
}
