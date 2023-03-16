import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/Components/DrawerItems.dart';

import 'DrawerItem.dart';

class DrawerWidget extends StatelessWidget {
 final ValueChanged<DrawerItem> onSelectedItem;

 const DrawerWidget({
   Key? key, required this.onSelectedItem,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildDrawerItems(context)
          ],
        )

      ),
    );



  }
 Widget buildDrawerItems(BuildContext context){
  return Column(
     children: DrawerItems.all.map((item) => ListTile(
       contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
       leading: Icon(item.icon, color: Colors.white),
       title: Text(
         item.title,
         style: GoogleFonts.poppins(
           textStyle: TextStyle(color: Colors.white, fontSize: 25),
         ),
       ),
       onTap: () => onSelectedItem(item),
     )).toList(),
   );
   }
}
