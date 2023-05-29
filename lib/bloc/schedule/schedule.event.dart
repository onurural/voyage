import 'package:voyage/models/schedule.dart';
abstract class ScheduleEvent {}

class PostSchedule extends ScheduleEvent {
  late Schedule schedule;
  
  PostSchedule({required this.schedule });
}

class GetUserSchedule extends ScheduleEvent {
  late String userId;
  
  GetUserSchedule({required this.userId });
}

