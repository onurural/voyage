import 'package:voyage/models/autocomplete-prediction.dart';

abstract class AutocompleteState {}

class AutocompleteInitialState extends AutocompleteState {}

class AutocompleteLoadingState extends AutocompleteState {}

class AutocompleteLoadedState extends AutocompleteState {
  final List<Predictions> predictions;

  AutocompleteLoadedState(this.predictions);
}

class AutocompleteErrorState extends AutocompleteState {
  final String message;

  AutocompleteErrorState(this.message);
}