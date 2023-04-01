import 'package:flutter/material.dart';
import 'package:voyage/ui-components/nav-bar.dart';
import 'package:voyage/ui-components/home-view-components/Place.dart';
import 'package:voyage/ui-components/schedule-screen-components/Activity.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule.dart';
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

  List<Activity> activities =[];

  final List<Widget> _screens = [

  ];
  var testPlace=Place(['assets/Images/1.jpeg','assets/Images/2.jpeg','assets/Images/3.jpeg','assets/Images/4.jpeg', 'assets/Images/5.jpeg'],'Barcelona', 'Barcelona is a city with a wide range of original leisure options that encourage you to visit time and time again. Overlooking the Mediterranean Sea, and famous for Gaudí and other Art Nouveau architecture, Barcelona is one of Europe’s trendiest cities.', 3.5);


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activities=List.generate(80, (index) {
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
        'https://www.google.com/maps/place/Location+$activityNumber',
      );
    });
    List<Schedule> schedules=[];
    for(int i=0;i<10;i++){
      schedules.add(Schedule(activities, testPlace));
    }
    _screens.add(const HomeCon());
    _screens.add(SchedulesScreen(schedules));
    _screens.add(const CreateScheduleScreen());

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
                Offstage(
                  offstage: _currentIndex != i,
                  child:    AnimatedOpacity(
                    opacity: _currentIndex == i ? 1.0 : 0.0,
                    duration:  const Duration(milliseconds: 500),
                    child: _screens[i],
                  ),
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

