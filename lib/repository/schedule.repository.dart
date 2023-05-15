import 'package:voyage/models/schedule.dart';
import 'package:voyage/models/user-schedules.dart';

abstract class ScheduleRepository {
  Future<bool> postSchedule({required Schedule schedule});
  Future<List<UserSchedule>> fetchSchedule({required String userId});
}