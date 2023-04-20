
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/place/place.bloc.dart';
import 'package:voyage/bloc/place/place.event.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'package:voyage/data/place.data.dart';
import 'package:voyage/ui-components/home-view-components/category-places-list.dart';

import 'category.dart';
import 'category-card.dart';

class CategoryCardsList extends StatefulWidget {
  const CategoryCardsList({Key? key}) : super(key: key);

  @override
  State<CategoryCardsList> createState() => _CategoryCardsListState();
}

class _CategoryCardsListState extends State<CategoryCardsList>
    with TickerProviderStateMixin {

  final PlaceBloc _placeBloc = PlaceBloc(PlaceData());

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



 var categories=[Category('History',const CategoryPlacesList(),Icons.museum_outlined),Category('Nature',const CategoryPlacesList(),CupertinoIcons.tree),Category('Shopping',const CategoryPlacesList(),Icons.shopping_bag),Category('Sport',const CategoryPlacesList(),Icons.sports_volleyball),Category('Gastronomy',const CategoryPlacesList(),Icons.fastfood),Category('Health',const CategoryPlacesList(),Icons.spa_outlined),Category('Entertainment',const CategoryPlacesList(),Icons.theater_comedy),];
 List<CategoryCard> categoryCards=[] ;

 void fillInTheList(){
   for (var element in categoryCards) {
     categoryItems.add(element.category.cardsList);
   }
 }


 void fillInTheArray(){
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
    _placeBloc.add(FetchHistoricPlace());
    // fillInTheList();
    _tabController = TabController(length: categoryCards.length, vsync: this);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
    mapCategoryItemsWithAnimation();
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
    return Column(
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
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: TabBar(
            onTap: (index) {
              _animationController.forward(from: 0);
              _placeBloc.add(FetchNaturalPlace());
            },
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            isScrollable: true,
            tabs: categoryCards,
            controller: _tabController,
          ),
        ),
         _buildPlaceCard()
      ],
    );
  }

  Widget _buildPlaceCard() {
    return 
      BlocProvider(
      create: (_) => _placeBloc,
      child: BlocConsumer<PlaceBloc, PlaceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PlaceLoadedState) {
              return Text("${state.model[0].category}"); // TODO: A nice looking widget need here. 
            }
            if (state is PlaceLoadingState) {
              return const CircularProgressIndicator();
            }
            if (state is PlaceErrorState) {
              return const Text('Error on display the widget');
            } else {
              return Text('Initial State ${state.toString()}');
            }
          }),
    );
  }
}
