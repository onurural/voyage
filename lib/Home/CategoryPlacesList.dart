import 'dart:math';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/Home/PlaceBigCard.dart';
import 'package:voyage/Home/PlaceSmallCard.dart';

import '../PlaceScreen/hero_dialog_route.dart';
import 'Place.dart';
import 'ShowMoreScreen.dart';

class CategoryPlacesList extends StatefulWidget {
  const CategoryPlacesList({Key? key}) : super(key: key);

  @override
  State<CategoryPlacesList> createState() => _CategoryPlacesListState();
}

class _CategoryPlacesListState extends State<CategoryPlacesList> {
  var testPlace=Place(['assets/Images/1.jpeg','assets/Images/2.jpeg','assets/Images/3.jpeg','assets/Images/4.jpeg', 'assets/Images/5.jpeg'],'Barcelona', 'Barcelona is a city with a wide range of original leisure options that encourage you to visit time and time again. Overlooking the Mediterranean Sea, and famous for Gaudí and other Art Nouveau architecture, Barcelona is one of Europe’s trendiest cities.', 3.5);
  bool buttonViewed=false;
  var globalId;
  List<PlaceSmallCard> smallCards=[];
  String generateRandomString(int length) {
    final rand = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const charLength = chars.length;
    String result = '';
    for (var i = 0; i < length; i++) {
      result += chars[rand.nextInt(charLength)];
    }
    return result;
  }

  final ScrollController _controller = ScrollController();


  List<PlaceBigCard> items=[];
  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        buttonViewed=true;

      });
    }
  }
  void fillInSmallCardList(){
    for (var element in items) {
      globalId=generateRandomString(3);
      smallCards.add(PlaceSmallCard(element.place, globalId));
    }
  }

  void generateList(){

    for(var i=0;i<=29;i++){
      globalId=generateRandomString(3);
      items.add(PlaceBigCard(testPlace,globalId));
    }

  }

  @override
  void initState() {

    super.initState();
    _controller.addListener(_scrollListener);

    generateList();
    fillInSmallCardList();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,

        child: Column(
            children: [

              SizedBox(
                width: double.infinity,
                height: 400,
                child: ListView.builder(
                  itemCount: 10,
                  controller: _controller,

                  scrollDirection: Axis.vertical,
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
                child: AnimatedCrossFade(firstChild: Container(), secondChild: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 7, 0, 20),
                  child: AnimatedCrossFade(firstChild: Container(), secondChild: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(
                          builder: (context) =>
                              Center(
                                  child: ShowMoreScreen(smallCards,globalId)),
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
                ), crossFadeState: buttonViewed? CrossFadeState.showSecond : CrossFadeState.showFirst , duration: const Duration(milliseconds: 100),


                ),
              )
            ])
    );
  }
}
