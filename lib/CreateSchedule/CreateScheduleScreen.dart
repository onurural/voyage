import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyage/CreateSchedule/BudgetContainer.dart';
import 'package:voyage/CreateSchedule/InterestContainer.dart';
import 'package:voyage/CreateSchedule/MatrixElement.dart';
import 'package:voyage/Home/SearchBar.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({Key? key}) : super(key: key);

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                  child: SearchBar([]),
                ),
                BudgetContainer()

              ])
      ),
    );
  }



  }

