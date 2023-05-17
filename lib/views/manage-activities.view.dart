import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:voyage/bloc/schedule/schedule.bloc.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/models/activity.dart';


import 'package:voyage/models/schedule.dart';
import 'package:voyage/ui-components/manage-activities-components/time-slot-column.dart';
import 'package:voyage/ui-components/manage-activities-components/to-manage-tile.dart';
import 'package:voyage/views/schedule-view/schedule.view.dart';


class ManageActivitiesScreen extends StatefulWidget {
  final String cityName;
  final List<Activity> activities;
  final DateTime beginDate;
  final DateTime endDate;
  final TimeOfDay beginTime;
  final TimeOfDay endTime;


  ManageActivitiesScreen({required this.cityName, required this.activities, required this.beginDate, required this.endDate,
      required this.beginTime, required this.endTime});

  @override
  State<ManageActivitiesScreen> createState() => _ManageActivitiesScreenState();
}

class _ManageActivitiesScreenState extends State<ManageActivitiesScreen> {
  final ScheduleBloc scheduleBloc=ScheduleBloc();
  List<Activity> _modifiedActivities = [];
  Map<String, ValueNotifier<List<Activity>>> activitiesNotifiers = {};
  Map<int, ValueNotifier<bool>> activityRemovedNotifiers = {};
  final AuthData _authData = AuthData();
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = _authData.getCurrentUserId();
    for (var activity in widget.activities) {
      activityRemovedNotifiers[activity.id!] = ValueNotifier<bool>(false);
    }

    final dayCount = widget.endDate.difference(widget.beginDate).inDays + 1;
    for (int dayIndex = 0; dayIndex < dayCount; dayIndex++) {
      DateTime currentDay = widget.beginDate.add(Duration(days: dayIndex));
      activitiesNotifiers.putIfAbsent(
        DateFormat('EEEE').format(currentDay),
            () => ValueNotifier<List<Activity>>([]),
      );

      timeSlotColumns[DateFormat('EEEE').format(currentDay)] = TimeSlotsColumn(
        startTime: widget.beginTime,
        endTime: widget.endTime,
        key: ValueKey(currentDay),
        activities: activitiesNotifiers[DateFormat('EEEE').format(currentDay)]!,
        activityRemovedNotifiers: activityRemovedNotifiers,
      );
    }
  }

  Map<String, TimeSlotsColumn> timeSlotColumns = {};

  Future<bool> addActivity(BuildContext context, Activity activity) async {
    // Show time picker dialog
    TimeOfDay? selectedStartTime = await showTimePicker(
      context: context,
      initialTime: widget.beginTime,
    );

    if (selectedStartTime == null) return false;

    TimeOfDay? selectedEndTime = await showTimePicker(
      context: context,
      initialTime: widget.endTime,
    );

    if (selectedEndTime == null) return false;

    // Show date picker dialog
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.beginDate,
      firstDate: widget.beginDate,
      lastDate: widget.endDate,
    );

    if (selectedDate == null) return false;

    // Show duration picker dialog
    int durationInMinutes = 30;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select duration'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: 200,
                child: Slider(
                  min: 30,
                  max: 300,
                  divisions: 9,
                  value: durationInMinutes.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      durationInMinutes = newValue.toInt();
                    });
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // Update the activity with the selected values
    setState(() {
      activity.beginTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedStartTime.hour,
        selectedStartTime.minute,
      );
      activity.endTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedEndTime.hour,
        selectedEndTime.minute,
      );
      activity.day = selectedDate;
      activity.duration = Duration(minutes: durationInMinutes);
      activitiesNotifiers[DateFormat('EEEE').format(selectedDate)]?.value.add(activity);
      timeSlotColumns = Map.from(timeSlotColumns);
    });

    return true;
  }

  Widget _buildTimetable() {
    final dayCount = widget.endDate.difference(widget.beginDate).inDays + 1;
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: DefaultTabController(
        length: dayCount,
        child: Column(
          children: [
            TabBar(
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
              tabs: List.generate(
                dayCount,
                    (index) {
                  DateTime currentDay =
                  widget.beginDate.add(Duration(days: index));
                  return Tab(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            DateFormat('EEEE').format(currentDay),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(currentDay),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                key: UniqueKey(),
                children: List.generate(dayCount, (dayIndex) {
                  DateTime currentDay =
                  widget.beginDate.add(Duration(days: dayIndex));
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return timeSlotColumns[
                      DateFormat('EEEE').format(currentDay)];
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Create Schedule'),

        ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildTimetable(),
          ),
          Wrap(
            spacing: 4.0, // Space between children along the horizontal axis
            runSpacing: 4.0, // Space between children along the vertical axis
            children: List.generate(
              widget.activities.length,
                  (index) {
                Activity activity = widget.activities[index];
                return ValueListenableBuilder<bool>(
                  valueListenable: activityRemovedNotifiers[activity.id]!,
                  builder: (context, isRemoved, child) {
                    if (isRemoved) {
                      return SizedBox.shrink(); // don't show anything if the activity was removed
                    } else {
                      return ToManageActivityTile(
                        activity,

                        onTap,
                        index,
                        activityRemovedNotifiers[activity.id]!,
                      );
                    }
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              List<Activity> tempActivities=[];
              this.activitiesNotifiers.forEach((key, value) {
                value.value.forEach((element) {
                  tempActivities.add(element);
                });
              });
              Schedule schedule=Schedule(tempActivities, widget.cityName, userId!);
              if(tempActivities.isNotEmpty){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>      BlocProvider(
                          create: (BuildContext context) => scheduleBloc, // You are creating bloc here
                          child: Builder( // Use Builder to get the context with the bloc provided above
                            builder: (context) {
                              final authBloc = BlocProvider.of<ScheduleBloc>(context); // Get the bloc from the context
                              return ScheduleScreen(schedule: schedule);
                            },
                          ),
                        )
                    ));
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
                'Next',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> onTap(index) async {
    bool result = await addActivity(context, widget.activities[index]);
    if (result) {
      setState(() {
        _modifiedActivities.add(widget.activities[index]);

      });
    }
    return result;
  }
}



