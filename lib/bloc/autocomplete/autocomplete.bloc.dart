import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/autocomplete/autocomplete.state.dart';
import 'package:voyage/data/city.data.dart';
import 'package:voyage/repository/city.repository.dart';
import 'autocomplete.event.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  CityRepository cityData = CityData();
  AutocompleteBloc() : super(AutocompleteInitialState()) {
    on<FetchCities>((event, emit) async {
      emit(AutocompleteLoadingState());
      try {
        final autocompletePrediction = await cityData.fetchCities(event.query);
        if (autocompletePrediction != null) {
          emit(AutocompleteLoadedState(autocompletePrediction));  
        }
      } catch (e) {
        emit(AutocompleteErrorState(e.toString()));
      }
    });
  }
}
