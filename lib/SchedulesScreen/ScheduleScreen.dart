import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:voyage/SchedulesScreen/Activity.dart';
import 'package:voyage/SchedulesScreen/Schedule.dart';

import 'ActivitySlide.dart';

class ScheduleScreen extends StatefulWidget {
  final Schedule schedule;

  ScheduleScreen({required this.schedule});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<DateTime, List<Activity>> activitiesByDay = {};
  @override
  void initState() {
    super.initState();
    // Sort activities by day

    for (Activity activity in widget.schedule.activities) {
      final day = DateTime(activity.beginTime.year, activity.beginTime.month, activity.beginTime.day);
      if (activitiesByDay.containsKey(day)) {
        activitiesByDay[day]!.add(activity);
      } else {
        activitiesByDay[day] = [activity];
      }
    }
    _tabController = TabController(
      length: activitiesByDay.keys.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define color palette and text styles

    Color primaryColor = Color.fromRGBO(44, 87, 116, 1);
    Color secondaryColor = Color.fromRGBO(235, 235, 235, 1);

    TextStyle tabTextStyle = GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: secondaryColor,
    );


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedule.title, style: TextStyle(color: secondaryColor)),
        backgroundColor: primaryColor,
        bottom:TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.blue,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          tabs: activitiesByDay.keys.map(
                (day) => Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEEE').format(day),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(day),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: activitiesByDay.values.map((activities) {
          activities.sort((a, b) => a.beginTime.compareTo(b.day));
          activities.sort((a, b) => a.beginTime.compareTo(b.beginTime));


          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              return ActivitySlide(activities[index]);
            },
          );
        }).toList(),
      ),
    );
  }
}
