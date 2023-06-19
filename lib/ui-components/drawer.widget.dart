// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/drawer-items.dart';
import 'package:voyage/views/auth.view.dart';

class DrawerWidget extends StatelessWidget {
  final ValueChanged<DrawerItem> onSelectedItem;
 FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  DrawerWidget({
    Key? key,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: SingleChildScrollView(
          child: Column(
        children: [buildDrawerItems(context)],
      )),
    );
  }

  Widget buildDrawerItems(BuildContext context) {
    return Column(
      children: DrawerItems.all
          .map((item) {
        if (item.widget != null) {
          return item.widget!;
        } else {
          return ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            leading: Icon(
              item.icon,
              color: Colors.white,
            ),
            title: Text(
              item.title,
              style: GoogleFonts.poppins(
                textStyle:
                const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            onTap: () async {
              if(item.title != 'Log Out'){
                onSelectedItem(item);
              }
              else {
                await firebaseAuth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              }
            },
          );
        }
      })
          .toList(),
    );
  }
}
