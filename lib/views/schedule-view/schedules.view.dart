import 'dart:math';
import 'package:flutter/material.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule-card.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule.dart';

class SchedulesScreen extends StatefulWidget {
  final List<Schedule> schedules;

  // ignore: prefer_const_constructors_in_immutables
  SchedulesScreen(this.schedules, {super.key});

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> with SingleTickerProviderStateMixin {
 late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1.0, // Adjust this value to change the aspect ratio
        ),
        itemCount: widget.schedules.length,
        itemBuilder: (BuildContext context, int index) {
          final random = Random();
          return AnimatedOpacity(
            duration: Duration(milliseconds: random.nextInt(800) + 400),
            opacity: _controller.value,
            child: AnimatedContainer(
              duration: Duration(milliseconds: random.nextInt(800) + 400),
              curve: Curves.easeInOut,
              child: IntrinsicHeight(
                child: ScheduleCard(widget.schedules[index], maxHeight: 300), // Add maxHeight to the ScheduleCard
              ),
            ),
          );
        },
      ),
    );
  }
}
