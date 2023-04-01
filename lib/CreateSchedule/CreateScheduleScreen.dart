
import 'package:flutter/material.dart';
import 'package:voyage/CreateSchedule/BudgetContainer.dart';
import 'package:voyage/CreateSchedule/DateBeginEndContainer.dart';
import 'package:voyage/CreateSchedule/FreeTimePerDayContainer.dart';

import 'package:voyage/CreateSchedule/InterestContainer.dart';
import 'package:voyage/CreateSchedule/TripCompanionsContainer.dart';

import 'package:voyage/Home/SearchBar.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({Key? key}) : super(key: key);

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
 void unlockNext(index){
setState(() {
  locked[index+1]=false;
});
 }
 List<bool> locked=[false,true,true,true,true,true];

  bool isFinished = false;
  bool isContentShown = false;
  var buttonIcon = Icons.add_circle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
                  child: SearchBar([]),
                ),
        DateBeginEndContainer(locked[0],unlockNext,0),
                FreeTimePerDayContainer(locked[1],unlockNext,1),
                BudgetContainer(locked[2],unlockNext,2),
                TripCompanionsContainer(locked[3],unlockNext,3),
                InterestContainer(locked[4],unlockNext,4),

              ])
      ),
    );
  }



  }

