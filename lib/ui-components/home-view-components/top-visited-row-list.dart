// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/place/place.bloc.dart';
import 'package:voyage/bloc/place/place.event.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'place-small-card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voyage/utility/page.enum.dart' as page;

class TopVisitedRowList extends StatefulWidget {
  const TopVisitedRowList({Key? key}) : super(key: key);

  @override
  State<TopVisitedRowList> createState() => _TopVisitedRowListState();
}

var globalId;

class _TopVisitedRowListState extends State<TopVisitedRowList> {
  final PlaceBloc _placeBloc = PlaceBloc();
  bool buttonViewed = false;
  int refreshCounter = 0;
  final _controller = ScrollController();


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

  List<PlaceSmallCard> items = [];



  void generateList() {
    for (var i = 0; i <= 29; i++) {
      globalId = generateRandomString(3);
    }
  }

  @override
  void initState() {
    super.initState();
    _placeBloc.add(FetchPlace(page.Page.first));
    globalId = generateRandomString(5);

    generateList();
  }

  @override
  Widget build(BuildContext context) {
    var poppins = GoogleFonts.poppins(
        textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ));
    var openSans = GoogleFonts.openSans(
        textStyle: const TextStyle(
            color: Color.fromRGBO(87, 99, 108, 100),
            fontWeight: FontWeight.w600));
    return SizedBox(
        width: double.infinity,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                'Top Visited Destinations',
                style: poppins,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 5, 0, 0),
              child: Text(
                'Locations world wide',
                style: openSans,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 184,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: _buildPlaceSmallCard(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 20),
            child: AnimatedCrossFade(
              firstChild: Container(),
              secondChild: GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   HeroDialogRoute(
                  //     builder: (context) =>
                  //         Center(child: ShowMoreScreen(items, globalId)),
                  //     settings: const RouteSettings(),
                  //     fullscreenDialog: true,
                  //   ),
                  // );
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
              ),
          crossFadeState: buttonViewed
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 100),
          ),
          )
        ]));
  }


  Widget _buildPlaceSmallCard() {
    return BlocProvider(
        create: (_) => _placeBloc,
        child: BlocConsumer<PlaceBloc, PlaceState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PlaceLoadedState) {
                return ListView.builder(
                  itemCount: state.model.length,
                  controller: _controller
                    ..addListener(() {
                      if (_controller.offset ==
                          _controller.position.maxScrollExtent) {
                        if (refreshCounter < 8) {
                          page.Page pageValue = page.Page.values
                              .where(
                                  (element) => element.index == refreshCounter)
                              .first;
                          refreshCounter++;
                          _placeBloc.add(FetchPlace(pageValue));
                        }
                      }
                    }),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return PlaceSmallCard(
                        state.model[index], generateRandomString(5));
                  },
                );
              }
              if (state is PlaceLoadingState) {
                return ListView.builder(
                    itemCount: 5, // Set the number of shimmer cards here
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                          ),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: 250.0, // Adjust the width to match your card
                              height: 184.0, // Adjust the height to match your card
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      );
                    });
              }
              if (state is PlaceErrorState) {
                return const Text('Error on display the widget');
              } else {
                return Text('Initial State ${state.toString()}');
              }
            }));
  }
}
