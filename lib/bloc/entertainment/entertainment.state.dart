import 'package:voyage/models/entertainment.dart';

abstract class EntertainmentState {}

class EntertainmentInitialState extends EntertainmentState {}

class EntertainmentLoadingState extends EntertainmentState {}

class EntertainmentLoadedState extends EntertainmentState {
  final List<Entertainment> model;
  EntertainmentLoadedState(this.model);
}

class EntertainmentErrorState extends EntertainmentState {
    final String errorMessage;
    EntertainmentErrorState(this.errorMessage);
}