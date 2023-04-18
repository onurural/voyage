import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ui-components/profile-components/city-cards.dart';
import '../../ui-components/profile-components/dashboard.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
           Column(
             children: [
               Container(
                 height: 400,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.withOpacity(0.5),
                       spreadRadius: 3,
                       blurRadius: 5,
                       offset: const Offset(0, 2),
                     ),
                   ],
                   image:  DecorationImage(
                     image: AssetImage("assets/Images/3.jpeg"),
                     fit: BoxFit.cover,

                   ) ,
                 )
               ),
               SizedBox(height: 10),
               Text(
                 'Your Name',
                 style: GoogleFonts.pacifico(
                     textStyle:  TextStyle(fontSize: 24, fontWeight: FontWeight.w800)
                 ),
               ),
             ],
           ),

            SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Interested Cities",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  CityCards(),
                ],
              ),
            ),
            Divider(
              color: 	Color.fromRGBO(211, 211, 211,100),
              thickness: 3,
            ),
            Dashboard(),

          ],
        ),
      ),
    );
  }
}