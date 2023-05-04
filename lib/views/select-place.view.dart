import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voyage/ui-components/select-place-componenets/select-place-card.dart';

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


  SelectPlaceScreen({
    required this.cityName,
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
    required this.endTime, required this.budget, required this.companion
  });

  @override
  _SelectPlaceScreenState createState() => _SelectPlaceScreenState();
}

class _SelectPlaceScreenState extends State<SelectPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.entertainment) buildCategory('Entertainment'),
              if (widget.gastronomy) buildCategory('Gastronomy'),
              if (widget.health) buildCategory('Health'),
              if (widget.shopping) buildCategory('Shopping'),
              if (widget.history) buildCategory('History'),
              if (widget.nature) buildCategory('Nature'),
              if (widget.sport) buildCategory('Sport'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory(String categoryName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            categoryName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SelectPlaceCard(),
              SelectPlaceCard(),
              SelectPlaceCard()
            ],
          ),
        ),
      ],
    );
  }
}