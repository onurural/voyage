// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:voyage/models/activity.dart';
import 'package:voyage/ui-components/nav-bar.dart';
import 'package:voyage/models/schedule.dart';
import 'package:voyage/views/profile.view/profile-view.dart';
import 'package:voyage/views/saved-documents.view.dart';
import 'package:voyage/views/schedule-view/schedules.view.dart';
import 'package:voyage/views/create-schedule.view.dart';
import 'home-container.dart';

class MainConnector extends StatefulWidget {
  const MainConnector({Key? key}) : super(key: key);

  @override
  State<MainConnector> createState() => _MainConnectorState();
}

class _MainConnectorState extends State<MainConnector> {
  int _currentIndex = 0;
  List<Activity> activities = [];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
              List<Schedule> schedules = [];
         List<Widget> screens = [
                const HomeCon(),
                SchedulesScreen(),
                const CreateScheduleScreen(),
                const SavedDocumentsScreen(),
                const ProfilePage(),
              ];
    return Scaffold(
      body:  Column(
                children: [
                  Expanded(
                    child: IndexedStack(
                      index: _currentIndex,
                      children: screens,
                    ),
                  ),
                  NavBar(onTap: _onItemTapped),
                ],
              )
    );
  }
}
