import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/place/place.event.dart';
import 'package:voyage/bloc/place/place.state.dart';

import '../../repository/place.repository.dart';
import '../../views/home-view/Place.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  late Place placeModel;
  final PlaceRepo placeRepo;

  PlaceBloc(this.placeRepo) : super(PlaceInitialState()) {
    on<PlaceEvent>((event, emit) async {
      if(event is FetchPlace) {
        emit(PlaceLoadingState());
        var places = await placeRepo.fetchPlace();
        emit(PlaceLoadedState(places));
      } else {
        //
      }
    });
  }
}