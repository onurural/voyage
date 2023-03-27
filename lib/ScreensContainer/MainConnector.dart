
import 'package:flutter/material.dart';
import 'package:voyage/SchedulesScreen/Schedule.dart';
import 'package:voyage/SchedulesScreen/ScheduleScreen.dart';


import '../Components/NavBar.dart';
import '../SchedulesScreen/Activity.dart';
import 'HomeCon.dart';

class MainConnector extends StatefulWidget {
  const MainConnector({Key? key}) : super(key: key);

  @override
  State<MainConnector> createState() => _MainConnectorState();
}

class _MainConnectorState extends State<MainConnector> {
  int _currentIndex = 0;

  List<Activity> activities = List.generate(80, (index) {
    int day = index ~/ 10;
    int activityNumber = index % 10 + 1;
    return Activity(
      'Activity $activityNumber',
      'Activity $activityNumber subtitle',
      (activityNumber % 5) + 0.5,
      'This is the description for activity $activityNumber.',
      DateTime(2023, 4, day + 1, 9 + activityNumber % 3, 0),
      DateTime(2023, 4, day + 1, 10 + activityNumber % 3, 0),
      DateTime(2023, 4, day + 1),
      [
        'https://images.pexels.com/photos/158028/bellingrath-gardens-alabama-landscape-scenic-158028.jpeg?cs=srgb&dl=pexels-pixabay-158028.jpg&fm=jpg',
        'https://wallpapercave.com/wp/wp2728594.jpg',
        'https://w0.peakpx.com/wallpaper/479/311/HD-wallpaper-beautiful-park-in-berlin-r-path-r-park-lawn-trees.jpg',
      ],
      'https://www.google.com/maps/place/Location+${activityNumber}',
    );
  });

  final List<Widget> _screens = [

  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screens.add(HomeCon());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [

                for (int i = 0; i < _screens.length; i++)
                  AnimatedOpacity(
                    opacity: _currentIndex == i ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: _screens[i],
                  ),
                Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: NavBar(onTap: _onItemTapped)),


              ],
            ),
          ),
        ],
      ),
    );
  }
}

