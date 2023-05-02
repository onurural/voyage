import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voyage/bloc/place/place.bloc.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/home-view-components/place-big-card.dart';
import 'package:voyage/ui-components/home-view-components/place-small-card.dart';
import 'package:voyage/ui-components/place-components/hero_dialog_route.dart';
import '../../views/show-more.view.dart';

class CategoryPlacesList extends StatefulWidget {
  const CategoryPlacesList({Key? key}) : super(key: key);

  @override
  State<CategoryPlacesList> createState() => _CategoryPlacesListState();
}

class _CategoryPlacesListState extends State<CategoryPlacesList> with AutomaticKeepAliveClientMixin {
  final PlaceBloc _placeBloc = PlaceBloc();
  bool buttonViewed = false;
  var globalId = '';

  List<PlaceSmallCard> smallCards = [];
  String generateRandomString(int length) {
    final rand = Random();
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const charLength = chars.length;
    String result = '';
    for (var i = 0; i < length; i++) {
      result += chars[rand.nextInt(charLength)];
    }
    return result;
  }

  final ScrollController _controller = ScrollController();

  List<PlaceBigCard> items = [];
  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        buttonViewed = true;
      });
    }
  }

  void fillInSmallCardList() {
    for (var element in items) {
      globalId = generateRandomString(3);
      smallCards.add(PlaceSmallCard(element.place, globalId));
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    fillInSmallCardList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Add this line
    return SizedBox(
        width: double.infinity,
        child: Column(children: [
          SizedBox(
          width: double.infinity,
          height: 500,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: _buildPlaceCard(),
          ),
        ),
        Padding(
        padding: const EdgeInsets.fromLTRB(0, 7, 0, 20),
    child: AnimatedCrossFade(
    firstChild: Container(),
    secondChild: Padding(
    padding: const EdgeInsets.fromLTRB(0, 7, 0, 20),
      child: AnimatedCrossFade(
        firstChild: Container(),
        secondChild: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              HeroDialogRoute(
                builder: (context) => Center(
                    child: ShowMoreScreen(smallCards, globalId)),
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
    ),
      crossFadeState: buttonViewed
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 100),
    ),
        )
        ]));
  }

  Widget _buildPlaceCard() {
    return ListView.builder(
      controller: _controller,
      scrollDirection: Axis.vertical,
      itemCount: 6,
      itemBuilder: ((context, index) {
        return BlocProvider(
          create: (context) => PlaceBloc(), // Create a new instance of PlaceBloc for each item
          child: BlocConsumer<PlaceBloc, PlaceState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PlaceLoadedState) {
                if (index < state.model.length) {
                  return PlaceBigCard(state.model[index], globalId);
                } else {
                  return const Text('Model is null or index out of range');
                }
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
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        height: 200, // Adjust the width to match your card

                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                );
              }
              if (state is PlaceErrorState) {
                return const Text('Error on display the widget');
              } else {
                return Text('Initial State ${state.toString()}');
              }
            },
          ),
        );
      }),
    );
  }


  @override
  bool get wantKeepAlive => true; // Add this line
}