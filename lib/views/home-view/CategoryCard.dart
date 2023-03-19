import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class CategoryCard extends StatefulWidget {
 final Category category;

 const CategoryCard(this.category, {super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [

        ],
      ),
    );
  }
}
