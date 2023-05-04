import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/city.data.dart';

import 'city_event.dart';
import 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityData cityData;

  CityBloc(this.cityData) : super(CityInitial()) {
    on<FetchCities>((event, emit) async {
      emit(CityLoading());
      try {
        final cities = await cityData.fetchCities(event.query);
        emit(CityLoaded(cities));
      } catch (e) {
        emit(CityError(e.toString()));
      }
    });
  }
}
