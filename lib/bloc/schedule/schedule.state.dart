import 'package:voyage/models/user-schedules.dart';

abstract class ScheduleState {}
class PostScheduleState extends ScheduleState {}

class PostScheduleUploadingState extends PostScheduleState {}
class PostScheduleInitialState extends PostScheduleState {}
class PostScheduleUploadedState extends PostScheduleState {
  final bool res;
  PostScheduleUploadedState(this.res);
}
class PostScheduleErrorState extends PostScheduleState {
  final String errorMessage;
  PostScheduleErrorState(this.errorMessage);
}

class GetScheduleState extends ScheduleState {}
class GetScheduleLoadingState extends GetScheduleState {}
class GetScheduleInitialState extends GetScheduleState {}
class GetScheduleLoadedState extends GetScheduleState {
  final List<UserSchedule> schedule;
  GetScheduleLoadedState(this.schedule);
}
class GetScheduleErrorState extends GetScheduleState {
  final String errorMessage;
  GetScheduleErrorState(this.errorMessage);
}