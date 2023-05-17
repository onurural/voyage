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

  SelectPlaceScreen(
      {required this.cityName,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      floatingActionButton: CustomFloatingActionButton(onPressed: (){
        if(activities.isNotEmpty){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageActivitiesScreen(cityName: widget.cityName, activities: activities, beginDate: widget.beginDate, endDate: widget.endDate, beginTime: widget.beginTime, endTime: widget.endTime)
            ),
          );
        }
        else{
          showErrorDialog(context, 'Please Select At Least One Activity');
        }

      }, icon: CupertinoIcons.check_mark,),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
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
