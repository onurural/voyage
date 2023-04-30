// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ui-components/profile-components/city-cards.dart';
import '../../ui-components/profile-components/dashboard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
            const SizedBox(height: 20),
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
                   image:  const DecorationImage(
                     image: AssetImage('assets/Images/3.jpeg'),
                     fit: BoxFit.cover,

                   ) ,
                 )
               ),
               const SizedBox(height: 10),
               Text(
                 'Your Name',
                 style: GoogleFonts.pacifico(
                     textStyle:  const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)
                 ),
               ),
             ],
           ),

            const SizedBox(height: 20),
            Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Interested Cities',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                CityCards(),
              ],
            ),
            const Divider(
              color: 	Color.fromRGBO(211, 211, 211,100),
              thickness: 3,
            ),
            const Dashboard(),

          ],
        ),
      ),
    );
  }
}