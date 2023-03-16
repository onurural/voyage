import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
         Color.fromRGBO(37, 154, 180, 100),
          Colors.black
        ],
           begin: Alignment.topCenter,
          end: Alignment.bottomCenter

        )
      )
      ,child: Column(
          children: [
           Container(

             padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
             child: Image.asset("assets/Images/Logo.png")
           ),
            Container(
             padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text("Whether it's coast or canyons, Victoria Falls or Antarctica: we're sure to have  an adventure tour that suits you best.",style: GoogleFonts.poppins(textStyle: TextStyle(
                color: Color.fromRGBO(241, 244, 248, 100),
                letterSpacing: 1,
                fontSize: 14,
                decoration: TextDecoration.none
              )),textAlign: TextAlign.center,),
            ),
            MaterialButton(onPressed: ()=>{

            },child: Text(
              "GET STARTED!",style: GoogleFonts.openSans(
              fontSize: 20,
              color: Color.fromRGBO(248, 132, 20, 100),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w700
            ),
            ),)

          ],
        ),
      ),
    );
  }
}
