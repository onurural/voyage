import 'dart:math';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/place/place.bloc.dart';
import 'package:voyage/bloc/place/place.event.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'package:voyage/data/place.data.dart';
import 'package:voyage/models/place.dart';
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

class _CategoryPlacesListState extends State<CategoryPlacesList> {
  final PlaceBloc _placeBloc = PlaceBloc(PlaceData());
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

  // void generateList(){

  //   for(var i=0;i<=29;i++){
  //     globalId=generateRandomString(3);
  //     items.add(PlaceBigCard(testPlace,globalId));
  //   }

  // }

  @override
  void initState() {

    super.initState();
    _placeBloc.add(FetchPlace());
    _controller.addListener(_scrollListener);

    // generateList();
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
                      child: _buildPlaceCard(),
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

  Widget _buildPlaceCard() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: ((context, index) {
      return BlocProvider(
        create: (_) => _placeBloc,
        child: BlocConsumer<PlaceBloc, PlaceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PlaceLoadedState) {
                return PlaceBigCard(state.model[index], globalId);
            }
            if (state is PlaceLoadingState) {
                return  const CircularProgressIndicator();
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

