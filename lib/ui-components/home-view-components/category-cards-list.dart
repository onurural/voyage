import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voyage/bloc/place/place.bloc.dart';
import 'package:voyage/bloc/place/place.event.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'package:voyage/ui-components/home-view-components/category-places-list.dart';
import 'package:voyage/ui-components/home-view-components/place-big-card.dart';
import 'package:voyage/utility/category.enum.dart';
import 'package:voyage/utility/page.enum.dart' as page;
import 'category.dart';
import 'category-card.dart';

class CategoryCardsList extends StatefulWidget {
  const CategoryCardsList({Key? key}) : super(key: key);

  @override
  State<CategoryCardsList> createState() => _CategoryCardsListState();
}

class _CategoryCardsListState extends State<CategoryCardsList>
    with TickerProviderStateMixin {
  final PlaceBloc _placeBloc = PlaceBloc();
  var refreshCounter = 1;
  var _tabIndex = 0;
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

  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  var categoryPlacesList = const CategoryPlacesList();
  var isListViewed = false;

  List<CategoryPlacesList> categoryItems = [];
  List<AnimatedBuilder> categoryItemsWithAnimation = [];

  void mapCategoryItemsWithAnimation() {
    for (var element in categoryItems) {
      categoryItemsWithAnimation.add(AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: _animation,
              child: element,
            );
          }));
    }
  }

  var categories = [
    Category('Historic', const CategoryPlacesList(), Icons.museum_outlined),
    Category('Natural', const CategoryPlacesList(), CupertinoIcons.tree),
    Category('City Vibes', const CategoryPlacesList(), CupertinoIcons.tree),
    Category('Rural', const CategoryPlacesList(), Icons.shopping_bag),
    Category('Medditerrain', const CategoryPlacesList(), Icons.sports_volleyball),
  ];
  
  List<CategoryCard> categoryCards = [];

  void fillInTheList() {
    for (var element in categoryCards) {
      categoryItems.add(element.category.cardsList);
    }
  }

  void fillInTheArray() {
    setState(() {
      for (var element in categories) {
        categoryCards.add(CategoryCard(element));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fillInTheArray();
    _placeBloc.add(FetchHistoricPlace(page.Page.first));
    // fillInTheList();
    _tabController = TabController(length: categoryCards.length, vsync: this);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
    mapCategoryItemsWithAnimation();
    fillInTheList();
    fillInTheArray();
    _tabController = TabController(length: categoryCards.length, vsync: this);
  }

  @override
  void dispose() {
    // Dispose the TabController when the widget is disposed
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _placeBloc,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                'Our Categories',
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
                'Choose one that matches your interests',
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(87, 99, 108, 100),
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            isScrollable: true,
            onTap: (value) {
              _tabIndex = value;
              if (value == 0) {
                return _placeBloc.add(FetchHistoricPlace(page.Page.first));
              } 
              if (value == 1) {
                 return _placeBloc.add(FetchNaturalPlace(page.Page.first));
              } 
              if (value == 2) {
                return _placeBloc.add(FetchCityVibesPlace(page.Page.first));
              } 
              if (value == 3) {
                return _placeBloc.add(FetchRuralPlace(page.Page.first));
              } 
              if (value == 4) {
                return _placeBloc.add(FetchMediterrainPlace(page.Page.first));
              }
            },
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            tabs: [
              categoryCards[0],
              categoryCards[1],
              categoryCards[2],
              categoryCards[3],
              categoryCards[4]
            ],
          ),
          SizedBox(
            height: 250,
            child: TabBarView(controller: _tabController, children: [
              place(),
              place(),
              place(),
              place(),
              place(),
            ]),
          )
        ],
      ),
    );
  }

  Future<void> refresh() async {
    if (refreshCounter < 2) {
      page.Page pageValue = page.Page.values.where((element) => element.index == refreshCounter).first;
      refreshCounter++;
      CATEGORY category = CATEGORY.values.where((element) => element.index == _tabIndex).first;
      await _updateCategory(category, pageValue);
    }
  }

  Future<void> _updateCategory(CATEGORY category, page.Page pageValue) async {
    switch (category) {
      case CATEGORY.historic:
        _placeBloc.add(FetchHistoricPlace(pageValue));
        break;
      case CATEGORY.cityVibes:
        _placeBloc.add(FetchCityVibesPlace(pageValue));
        break;
      case CATEGORY.mediterrain:
        _placeBloc.add(FetchMediterrainPlace(pageValue));
        break;
      case CATEGORY.natural:
        _placeBloc.add(FetchNaturalPlace(pageValue));
        break;
      case CATEGORY.rural:
        _placeBloc.add(FetchRuralPlace(pageValue));
        break;
      default:
    }
  }

  Widget place() {
    return RefreshIndicator(
        onRefresh: () async {
          await refresh();
        },
        child: SizedBox(
            height: 1000,
            child: BlocConsumer<PlaceBloc, PlaceState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is PlaceLoadedState) {
                    return ListView.builder(
                        itemCount: state.model.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PlaceBigCard(
                              state.model[index], generateRandomString(3));
                        });
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
                })));
  }
}
