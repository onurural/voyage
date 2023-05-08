
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/entertainment/entertainment.event.dart';
import 'package:voyage/bloc/entertainment/entertainment.state.dart';
import 'package:voyage/data/activity.data.dart';
import 'package:voyage/models/entertainment.dart';
import 'package:voyage/repository/activity.repository.dart';

class EntertainmentBloc extends Bloc<EntertainmentEvent, EntertainmentState> {
  final ActivityRepository activityData = ActivityData();
  EntertainmentBloc(): super(EntertainmentInitialState()) {
    on<EntertainmentEvent>((event, emit) async {
      if (event is FetchEntertainment) {
        try {
          emit(EntertainmentLoadingState());
          List<Entertainment> entertainments = await activityData.findEntertainment(city: event.city, minPrice: event.minPrice, maxPrice: event.maxPrice);
          emit(EntertainmentLoadedState(entertainments));
        } catch (e) {
          emit(EntertainmentErrorState(e.toString()));
        }
      }
    });
  }

}