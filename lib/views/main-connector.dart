import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/place.bloc.dart';
import 'package:voyage/bloc/place.event.dart';
import 'package:voyage/bloc/place.state.dart';
import 'package:voyage/data/place.data.dart';
import 'package:voyage/models/place.dart';
import 'package:voyage/ui-components/nav-bar.dart';
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
  final PlaceBloc _placeBloc = PlaceBloc(PlaceData());
  List<Activity> activities =[];

  final List<Widget> _screens = [];
  // var testPlace=Place(['assets/Images/1.jpeg','assets/Images/2.jpeg','assets/Images/3.jpeg','assets/Images/4.jpeg', 'assets/Images/5.jpeg'],'Barcelona', 'Barcelona is a city with a wide range of original leisure options that encourage you to visit time and time again. Overlooking the Mediterranean Sea, and famous for Gaudí and other Art Nouveau architecture, Barcelona is one of Europe’s trendiest cities.', 3.5);
  var places;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    _placeBloc.add(FetchPlace());
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
    // places = fetchPlace();
    // List<Schedule> schedules=[];
    
    // for(int i=0;i<10;i++){
    //   schedules.add(Schedule(activities, places[i]));
    // }
    // _screens.add(const HomeCon());
    // _screens.add(SchedulesScreen(schedules));
    // _screens.add(const CreateScheduleScreen());

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        children: [
        Expanded(
          child: Stack(
            children: [
              for (int i = 0; i < 3; i++)
                Offstage(
                  offstage: _currentIndex != i,
                  child:    AnimatedOpacity(
                    opacity: _currentIndex == i ? 1.0 : 0.0,
                    duration:  const Duration(milliseconds: 500),
                    child: _buildScreens(),
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

  Widget _buildScreens() {
    return BlocProvider(
        create: (_) => _placeBloc,
        child: BlocConsumer<PlaceBloc, PlaceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PlaceLoadedState) {
              List<Place> places = state.model;
              List<Schedule> schedules=[];
                for (var place in places) {
                  schedules.add(Schedule(activities, place));
                }
                   _screens.add(const HomeCon());
                  _screens.add(SchedulesScreen(schedules));
                  _screens.add(const CreateScheduleScreen());
                  return _screens[0];
            }
            else if (state is PlaceLoadingState) {
                return  const CircularProgressIndicator();
            }
            else if (state is PlaceErrorState) {
              return const Text('Error on display the widget');
            }
            else {
              return Text('Initial State ${state.toString()}');
            }
          }),
        );
  }
}

