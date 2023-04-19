import 'package:flutter/material.dart';
import 'package:voyage/models/place.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule-card.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule.dart';

class SchedulesScreen extends StatefulWidget {
  final List<Schedule> schedules;

  SchedulesScreen(this.schedules);

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: widget.schedules.length,
        itemBuilder: (BuildContext context, int index) {
          return ScheduleCard(widget.schedules[index]);
        },
      ),
    );
  }
}