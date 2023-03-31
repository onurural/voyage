import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/place/place.bloc.dart';
import 'package:voyage/bloc/place/place.state.dart';
import 'package:voyage/repository/place.repository.dart';

import '../../bloc/place/place.event.dart';
import 'PlaceSmallCard.dart';

class TopVisitedRowList extends StatefulWidget {
  const TopVisitedRowList({Key? key}) : super(key: key);

  @override
  State<TopVisitedRowList> createState() => _TopVisitedRowListState();
}

class _TopVisitedRowListState extends State<TopVisitedRowList> {
  final PlaceBloc _placeBloc = PlaceBloc(PlaceRepo());

  // var testPlace=Place(['assets/Images/1.jpeg','assets/Images/2.jpeg','assets/Images/3.jpeg','assets/Images/4.jpeg', 'assets/Images/5.jpeg'],'Barcelona', 'Barcelona is a city with a wide range of original leisure options that encourage you to visit time and time again. Overlooking the Mediterranean Sea, and famous for Gaudí and other Art Nouveau architecture, Barcelona is one of Europe’s trendiest cities.', 3.5);
  bool buttonViewed = false;
  Container viewMoreButton = Container(
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(7)),
    child: MaterialButton(
      onPressed: () {},
      child: Text(
        'View More',
        style: GoogleFonts.poppins(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
  );
  final ScrollController _controller = ScrollController();
  List<PlaceSmallCard> items = [];
  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        buttonViewed = true;
      });
    }
  }

  // void generateList(){
  //   for(var i=0;i<=29;i++){
  //   items.add(PlaceSmallCard(testPlace));
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _placeBloc.add(FetchPlace());
    _controller.addListener(_scrollListener);
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
              width: double.infinity, height: 184, child: _buildPlaceCard()),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 20),
            child: AnimatedCrossFade(
              firstChild: Container(),
              secondChild: viewMoreButton,
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
      itemCount: 6,
      controller: _controller,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return BlocProvider(
            create: (_) => _placeBloc,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: BlocConsumer<PlaceBloc, PlaceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is PlaceLoadedState) {
                        return PlaceSmallCard(state.model[index]);
                      } else if (state is PlaceLoadingState) {
                        return const CircularProgressIndicator();
                      } else if (state is PlaceErrorState) {
                        return ErrorWidget(Exception);
                      } else {
                        return Text('Initial State ${state.toString()}');
                      }
                    })));
      },
    );
  }
}
