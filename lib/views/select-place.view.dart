// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyage/models/activity.dart';
import 'package:voyage/ui-components/select-place-componenets/select-entertainment-card.dart';
import 'package:voyage/ui-components/select-place-componenets/select-place-to-travel.dart';
import 'package:voyage/ui-components/select-place-componenets/select-restaurant-card.dart';

import '../ui-components/custom-error-dialog.dart';
import '../ui-components/saved-documents-components/custom-floating-action-button.dart';
import 'manage-activities.view.dart';
class SelectPlaceScreen extends StatefulWidget {
  final String cityName;
  final bool entertainment;
  final bool gastronomy;
  final bool health;
  final bool shopping;
  final bool history;
  final bool nature;
  final bool sport;
  final DateTime beginDate;
  final DateTime endDate;
  final TimeOfDay beginTime;
  final TimeOfDay endTime;
  final double budget;
  final String companion;

  const SelectPlaceScreen(
      {super.key, required this.cityName,
      required this.entertainment,
      required this.gastronomy,
      required this.health,
      required this.shopping,
      required this.history,
      required this.nature,
      required this.sport,
      required this.beginDate,
      required this.endDate,
      required this.beginTime,
      required this.endTime,
      required this.budget,
      required this.companion});

  @override
  _SelectPlaceScreenState createState() => _SelectPlaceScreenState();
}

class _SelectPlaceScreenState extends State<SelectPlaceScreen> {
List<Activity> activities=[];
void addToActivities(Activity activity){
 setState(() {
   activities.add(activity);
 });
}
void removeFromActivities(Activity activity){
  setState(() {
    activities.removeWhere((element) => element.id == activity.id);
  });
}
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'screen1',
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(24, 42, 64, 1),
          title: Text(widget.cityName),

        ),
        floatingActionButton: CustomFloatingActionButton(onPressed: (){
          if(activities.isNotEmpty){
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ManageActivitiesScreen(cityName: widget.cityName, activities: activities, beginDate: widget.beginDate, endDate: widget.endDate, beginTime: widget.beginTime, endTime: widget.endTime),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ));
          }
          else{
            showErrorDialog(context, 'Please Select At Least One Activity');
          }

        }, icon: CupertinoIcons.check_mark,),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            height: 1200,
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildMustSeeCategory(),
                   buildRestaurantCategory(),
                   buildEntertainmentCategory()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMustSeeCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.all(16.0),
          child: Text(
            'Must See',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300,
            width: double.infinity,
            child: SelectPlaceToTravelCard(widget.cityName,addToActivities,removeFromActivities)),
      ],
    );
  }
    Widget buildRestaurantCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.all(16.0),
          child: Text(
            'Gastronomy',
            style:  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300,
            width: double.infinity
            ,child: SelectRestaurantCard(widget.cityName,addToActivities,removeFromActivities)),
      ],
    );
  }
    Widget buildEntertainmentCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Entertainment',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300,
            width: double.infinity,
            child: SelectEntertainmentCard(widget.cityName,addToActivities,removeFromActivities)),
      ],
    );
  }
}
