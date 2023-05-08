import 'package:flutter/material.dart';
import 'package:voyage/ui-components/select-place-componenets/select-entertainment-card.dart';
import 'package:voyage/ui-components/select-place-componenets/select-place-to-travel.dart';
import 'package:voyage/ui-components/select-place-componenets/select-restaurant-card.dart';
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SelectPlaceToTravelCard(widget.cityName),
            ],
          ),
        ),
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SelectRestaurantCard(widget.cityName),
            ],
          ),
        ),
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SelectEntertainmentCard(widget.cityName)
            ],
          ),
        ),
      ],
    );
  }
}
