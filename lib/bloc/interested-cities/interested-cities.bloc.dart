import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/interested-cities/interested-cities.event.dart';
import 'package:voyage/bloc/interested-cities/interested-cities.state.dart';
import 'package:voyage/data/interested-city.data.dart';
import 'package:voyage/repository/interested-city.repository.dart';


class InterestedCityBloc extends Bloc<InterestedCityEvent, InterestedCityState> {
  final InterestedCityRepository interestedCitiesRepository = InterestedCityData();
  InterestedCityBloc(): super(InterestedCityLoadingState()) {
    on<InterestedCityEvent>((event, emit) async {
      if (event is FetchInterestedCity) {
        emit(InterestedCityLoadingState());
        try {
          var interestedCities = await interestedCitiesRepository.fetchInterestedCities(userId: event.userId);
          emit(InterestedCitySuccessState(interestedCities));
        } catch (e) {
          emit(InterestedCityErrorState(e.toString()));
        }
      }
    });
  }
}