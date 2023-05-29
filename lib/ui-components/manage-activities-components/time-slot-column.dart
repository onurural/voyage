// ignore_for_file: file_names, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:voyage/models/activity.dart';


class TimeSlotsColumn extends StatefulWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  ValueNotifier<List<Activity>> activities;
  Map<int, ValueNotifier<bool>> activityRemovedNotifiers;

  TimeSlotsColumn(
      {Key? key,
      required this.startTime,
      required this.endTime,
      required this.activities,
      required this.activityRemovedNotifiers})
      : super(key: key);

  @override
  State<TimeSlotsColumn> createState() => _TimeSlotsColumnState();
}

class _TimeSlotsColumnState extends State<TimeSlotsColumn>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<List<Activity>>(
      valueListenable: widget.activities,
      builder: (context, activities, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              generateTimeSlots(widget.startTime, widget.endTime, activities),
        );
      },
    );
  }

  List<Widget> generateTimeSlots(TimeOfDay startTime, TimeOfDay endTime, List<Activity> activities) {
    if (endTime == null) {
      throw ArgumentError('Start time and end time must be provided.');
    }

    DateTime startDateTime = timeOfDayToDateTime(startTime);
    DateTime endDateTime = timeOfDayToDateTime(endTime);

    if (startDateTime.isAfter(endDateTime)) {
      throw ArgumentError('End time must be after start time.');
    }

    List<Widget> timeSlots = [];

    // Ensure activities are not null
    activities = activities ?? [];

    // Sort activities by begin time
    activities.sort((a, b) => a.beginTime!.compareTo(b.beginTime!));

    DateTime current = startDateTime;
    for (Activity activity in activities) {
      if (activity.beginTime == null || activity.endTime == null) {
        throw ArgumentError('Activity must have both begin time and end time.');
      }

      // If there's a gap between the current time and the start of the activity, create a free-time slot
      // Make sure there is an actual gap (more than 0 minutes)
      if (current.isBefore(activity.beginTime!) && current != activity.beginTime) {
        timeSlots.add(timeSlot(formatTimeSlot(current, activity.beginTime!), null));
      }

      // Add the activity
      timeSlots.add(timeSlot(formatTimeSlot(activity.beginTime!, activity.endTime!), activity));

      // Move the current time to the end of the activity
      current = activity.endTime!;
    }

    // If there's time left after the last activity, create a final free-time slot
    if (current.isBefore(endDateTime)) {
      timeSlots.add(timeSlot(formatTimeSlot(current, endDateTime), null));
    }

    return timeSlots;
  }

  int calculateDifferenceInMinutes(DateTime startTime, DateTime endTime) {
    return endTime.difference(startTime).inMinutes;
  }

  String formatTimeSlot(DateTime start, DateTime end) {
    return '${DateFormat('h:mm a').format(start)}-${DateFormat('h:mm a').format(end)}';
  }

  DateTime timeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  TimeOfDay dateTimeToTimeOfDay(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  Widget timeSlot(String currentFormatted, Activity? currentActivity) {
    return GestureDetector(
      onTap: currentActivity != null
          ? () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Remove activity?'),
                  content: const Text('Do you want to remove this activity?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('Remove'),
                      onPressed: () {
                        setState(() {
                          widget.activityRemovedNotifiers[currentActivity.id]?.value=false;
                          widget.activities.value.remove(currentActivity);

                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )
          : null,
      child: AnimatedOpacity(
        opacity: currentActivity == null ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(37, 154, 180, 100),
                  Color.fromRGBO(37, 154, 180, 50)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(5),
              border: const Border.fromBorderSide(
                  BorderSide(color: Colors.grey, width: 2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: const Border.fromBorderSide(BorderSide(
                        color: Color.fromRGBO(37, 154, 180, 100), width: 2)),
                  ),
                  child: Text(
                    currentFormatted,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(37, 154, 180, 100))),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: const Border.fromBorderSide(BorderSide(
                          color: Color.fromRGBO(37, 154, 180, 100), width: 2)),
                    ),
                    child: Center(
                      child: Text(
                        currentActivity == null
                            ? 'Free Time'
                            : currentActivity.title!,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(37, 154, 180, 100))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int calculateDifference(TimeOfDay startTime, TimeOfDay endTime) {
    // Calculate the difference in hours
    int difference = endTime.hour - startTime.hour;

    return difference;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
