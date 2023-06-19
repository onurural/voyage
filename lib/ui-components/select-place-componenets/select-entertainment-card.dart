import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voyage/bloc/entertainment/entertainment.bloc.dart';
import 'package:voyage/bloc/entertainment/entertainment.event.dart';
import 'package:voyage/bloc/entertainment/entertainment.state.dart';
import 'package:voyage/models/activity.dart';
import 'package:voyage/ui-components/select-place-componenets/inner-entertainment-card.dart';
import 'package:voyage/utility/min-price.enum.dart';

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

                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  );
                });
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
            Activity temp=Activity(beginTime: null, endTime: null, day: null, title: '${state.model[index].name}', category: 'Entertainment', rate: double.parse( '${state.model[index].rating}'), description: 'desc', photos: [], placeID: '${state.model[index].placeId}', duration: null, photosLinks: []);
            print('activity id: ${state.model[index].placeId}');
              return InnerEntertainmentActivityCard(state.model[index], temp,widget.addActivity,widget.removeActivity);
          }),
    );
  }


}
