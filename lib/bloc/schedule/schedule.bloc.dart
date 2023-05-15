
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:voyage/bloc/schedule/schedule.event.dart';
import 'package:voyage/bloc/schedule/schedule.state.dart';
import 'package:voyage/data/schedule.data.dart';
import 'package:voyage/models/user-schedules.dart';
import 'package:voyage/repository/schedule.repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleData = ScheduleData();
  ScheduleBloc(): super(PostScheduleInitialState()) {
    on<ScheduleEvent>((event, emit) async {
      if (event is PostSchedule) {
        try {
            emit(PostScheduleUploadingState());
            bool res = await scheduleData.postSchedule(schedule: event.schedule);
            emit(PostScheduleUploadedState(res));
        } catch (e) {
            emit(PostScheduleErrorState(e.toString()));
        }
      }
      if (event is GetUserSchedule) {
        try {
            emit(GetScheduleLoadingState());
            List<UserSchedule> schedule = await scheduleData.fetchSchedule(userId: event.userId);
            emit(GetScheduleLoadedState(schedule));
        } catch (e) {
            emit(GetScheduleErrorState(e.toString()));
        }
      }
        
    });
  }

}