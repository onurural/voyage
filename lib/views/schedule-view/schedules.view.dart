import 'package:flutter/material.dart';
import 'package:voyage/ui-components/home-view-components/Place.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule-card.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule.dart';

class SchedulesScreen extends StatefulWidget {
  final List<Schedule> schedules;

  SchedulesScreen(this.schedules);

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  var testPlace =
  // Place(['assets/Images/1.jpeg', 'assets/Images/2.jpeg', 'assets/Images/3.jpeg', 'assets/Images/4.jpeg', 'assets/Images/5.jpeg'], 'Barcelona', 'Barcelona is a city with a wide range of original leisure options that encourage you to visit time and time again. Overlooking the Mediterranean Sea, and famous for Gaudí and other Art Nouveau architecture, Barcelona is one of Europe’s trendiest cities.', 3.5);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: widget.schedules.length,
        itemBuilder: (BuildContext context, int index) {
          return ScheduleCard(widget.schedules[index]);
        },
      ),
    );
  }
}