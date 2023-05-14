import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voyage/bloc/entertainment/entertainment.bloc.dart';
import 'package:voyage/bloc/entertainment/entertainment.event.dart';
import 'package:voyage/bloc/entertainment/entertainment.state.dart';
import 'package:voyage/bloc/restaurant/restaurant.state.dart';
import 'package:voyage/data/photos-fetcher.data.dart';


import 'package:voyage/models/entertainment.dart';
import 'package:voyage/utility/min-price.enum.dart';

import '../../bloc/photos-fetcher/photos-fetcher-bloc.dart';
import '../schedule-screen-components/Activity.dart';
import 'InnerActivityCard.dart';

class SelectEntertainmentCard extends StatefulWidget {
  String cityName;

  final Function(Activity) addActivity;
  final Function(Activity) removeActivity;
  SelectEntertainmentCard(this.cityName,this.addActivity ,this.removeActivity,{super.key});

  @override
  State<SelectEntertainmentCard> createState() => _SelectEntertainmentCard();
}

class _SelectEntertainmentCard extends State<SelectEntertainmentCard>
    {


  final EntertainmentBloc _entertainmentBloc = EntertainmentBloc();

  @override
  void initState() {
    super.initState();
    _entertainmentBloc.add(FetchEntertainment(city: widget.cityName, minPrice: Price.zero, maxPrice: Price.four));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _entertainmentBloc,
      child: BlocConsumer<EntertainmentBloc, EntertainmentState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EntertainmentLoadedState) {
            return entertainments(state); 
          }
          if (state is EntertainmentLoadingState) {
            return Container();
          }
          if (state is EntertainmentErrorState) {
            return const Text('Error');  
          }
          if (state is EntertainmentInitialState) {
            return const Text('Initital State');
          }
          return const Text('Unrecognized Error');
        },
      ),
    );
  }

  SizedBox entertainments(EntertainmentLoadedState state) {
    return SizedBox(
      height: 300,
      width: double.maxFinite,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: state.model.length,
            itemBuilder: (context, index) {
            Activity temp=Activity(beginTime: null, endTime: null, day: null, title: '${state.model[index].name}', category: 'Entertainment', rate: double.parse( '${state.model[index].rating}'), description: 'desc', photos: null, placeID: '${state.model[index].placeId}', duration: null);
              return BlocProvider(create: (context) => PhotosFetcherBloc(data: PhotosFetcherData()),
                child:  InnerActivityCard(temp,widget.addActivity,widget.removeActivity),
              );
            },
          ),
    );
  }


}
