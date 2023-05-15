// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:voyage/bloc/schedule/schedule.bloc.dart';
import 'package:voyage/bloc/schedule/schedule.event.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/models/activity.dart';
import 'package:voyage/models/schedule.dart';


class ScheduleScreen extends StatefulWidget {
  final Schedule schedule;

  const ScheduleScreen({super.key, required this.schedule});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  final AuthData _authData = AuthData();
  final ScheduleBloc _scheduleBloc = ScheduleBloc();
  String? userId;
  late TabController _tabController;
  Map<DateTime, List<Activity>> activitiesByDay = {};
  @override
  void initState() {
    super.initState();
    userId = _authData.getCurrentUserId();

    for (Activity activity in widget.schedule.activities) {
      final day = DateTime(activity.beginTime!.year, activity.beginTime!.month, activity.beginTime!.day);
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

    Color primaryColor = const Color.fromRGBO(44, 87, 116, 1);
    Color secondaryColor = const Color.fromRGBO(235, 235, 235, 1);



    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedule.title, style: TextStyle(color: secondaryColor)),
        backgroundColor: primaryColor,
        bottom:TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.blue,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          tabs: activitiesByDay.keys.map(
                (day) => Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEEE').format(day),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(day),
                    style: const TextStyle(
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
      body: Column(
        children: [
          // TabBarView(
          //   controller: _tabController,
          //   children: activitiesByDay.values.map((activities) {
          //     activities.sort((a, b) => a.beginTime!.compareTo(b.day!));
          //     activities.sort((a, b) => a.beginTime!.compareTo(b.beginTime!));
          //       return ListView.builder(
          //       itemCount: activities.length,
          //       itemBuilder: (context, index) {
          //         return ActivitySlide(activities[index]);
          //       },
          //     );
          //   }).toList(),
          // ),
          _saveButton()
        ],
      ),
      // floatingActionButton: _saveButton(),
    );
  }

  _saveButton() {
    return     ElevatedButton(
            onPressed: () {
      if (userId != null) {
        _scheduleBloc.add(PostSchedule(schedule: widget.schedule));
      }
    },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(24, 42, 64, 1),



              padding: const EdgeInsets
                  .symmetric(
                  vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                'Save',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}
