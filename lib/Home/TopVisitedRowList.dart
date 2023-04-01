
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/Home/ShowMoreScreen.dart';
import 'package:voyage/model/place.dart';

import '../PlaceScreen/PlaceScreen.dart';
import '../PlaceScreen/hero_dialog_route.dart';
import 'Place.dart';
import 'PlaceSmallCard.dart';
class TopVisitedRowList extends StatefulWidget {
  const TopVisitedRowList({Key? key}) : super(key: key);

  @override
  State<TopVisitedRowList> createState() => _TopVisitedRowListState();
}
var globalId;
class _TopVisitedRowListState extends State<TopVisitedRowList> {
  var testPlace=Placez(['assets/Images/1.jpeg','assets/Images/2.jpeg','assets/Images/3.jpeg','assets/Images/4.jpeg', 'assets/Images/5.jpeg'],'Barcelona', 'Barcelona is a city with a wide range of original leisure options that encourage you to visit time and time again. Overlooking the Mediterranean Sea, and famous for Gaudí and other Art Nouveau architecture, Barcelona is one of Europe’s trendiest cities.', 3.5);
  bool buttonViewed=false;


  final ScrollController _controller = ScrollController();
  String generateRandomString(int length) {
    final rand = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const charLength = chars.length;
    String result = '';
    for (var i = 0; i < length; i++) {
      result += chars[rand.nextInt(charLength)];
    }
    return result;
  }

  List<PlaceSmallCard> items=[];
  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        buttonViewed=true;

      });
    }
  }

  void generateList(){

    for(var i=0;i<=29;i++){
      globalId=generateRandomString(3);
    items.add(PlaceSmallCard(Place()));
    }

  }
  @override
  void initState() {

    super.initState();
    _controller.addListener(_scrollListener);
    globalId = generateRandomString(5);

    generateList();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,

        child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0,0 ),
                  child: Text('Top Visited Destinations',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,

                        )
                    ),

                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft
                ,child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 5, 0, 0),
                child: Text('30 locations world wide',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(87, 99, 108, 100),
                          fontWeight: FontWeight.w600
                      )
                  ),),
              ),
              ),
              SizedBox(
                width: double.infinity,
                height: 184,
                child: ListView.builder(
                  itemCount: 10,
                  controller: _controller,

                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {


                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: items[index],
                    );
                  },
                ),
              ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 7, 0, 20),
                 child: AnimatedCrossFade(firstChild: Container(), secondChild: GestureDetector(
                   onTap: () {
                     Navigator.of(context).push(
                       HeroDialogRoute(
                         builder: (context) =>
                             Center(
                                 child: ShowMoreScreen(items,globalId)),
                         settings: const RouteSettings(),
                         fullscreenDialog: true,
                       ),
                     );
                   },
                   child: Hero(
                     tag: globalId,
                     child: Container(
                       padding: const EdgeInsets.all(10),
                       decoration: BoxDecoration(
                         color: Colors.black,
                         borderRadius: BorderRadius.circular(7),
                       ),
                       child: Text(
                         'View More',
                         style: GoogleFonts.poppins(
                           color: Colors.white,
                           fontWeight: FontWeight.w600,
                           fontSize: 16,
                         ),
                       ),
                     ),
                   ),
                 ), crossFadeState: buttonViewed? CrossFadeState.showSecond : CrossFadeState.showFirst , duration: const Duration(milliseconds: 100),


              ),
               )
            ])
    );
  }
}
