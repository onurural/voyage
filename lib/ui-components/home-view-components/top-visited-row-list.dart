import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/place/place.bloc.dart';
import 'package:voyage/bloc/place/place.event.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'package:voyage/data/place.data.dart';
import 'package:voyage/views/show-more.view.dart';
import 'package:voyage/ui-components/place-components/hero_dialog_route.dart';
import 'place-small-card.dart';
import 'package:shimmer/shimmer.dart';


class TopVisitedRowList extends StatefulWidget {
  const TopVisitedRowList({Key? key}) : super(key: key);

  @override
  State<TopVisitedRowList> createState() => _TopVisitedRowListState();
}

var globalId;

class _TopVisitedRowListState extends State<TopVisitedRowList> {
  final PlaceBloc _placeBloc = PlaceBloc();
  bool buttonViewed = false;

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

  List<PlaceSmallCard> items = [];
  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        buttonViewed = true;
      });
    }
  }

  void generateList() {
    for (var i = 0; i <= 29; i++) {
      globalId = generateRandomString(3);
      // items.add(PlaceSmallCard(testPlace, globalId));
    }
  }

  @override
  void initState() {
    super.initState();
    _placeBloc.add(FetchPlace());
    _controller.addListener(_scrollListener);
    globalId = generateRandomString(5);

    generateList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                'Top Visited Destinations',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 5, 0, 0),
              child: Text(
                '30 locations world wide',
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(87, 99, 108, 100),
                        fontWeight: FontWeight.w600)),
              ),
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
                  child: _buildPlaceSmallCard(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 20),
            child: AnimatedCrossFade(
              firstChild: Container(),
              secondChild: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    HeroDialogRoute(
                      builder: (context) =>
                          Center(child: ShowMoreScreen(items, globalId)),
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
    return ListView.separated(
        separatorBuilder: (_, __) => const Divider(),
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return BlocProvider(
            create: (_) => _placeBloc,
            child: BlocConsumer<PlaceBloc, PlaceState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is PlaceLoadedState) {
                    return PlaceSmallCard(state.model[index], globalId);
                  }
                  if (state is PlaceLoadingState) {
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
                              offset:  const Offset(0, 2),
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
                  }
                  if (state is PlaceErrorState) {
                    return const Text('Error on display the widget');
                  }
                  else {
                    return Text('Initial State ${state.toString()}');
                  }
                }),
          );
        }));
  }

}
