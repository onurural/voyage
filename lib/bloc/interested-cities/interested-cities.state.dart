
import 'package:voyage/models/interested-city.dart';

abstract class InterestedCityState {}

class InterestedCityLoadingState extends InterestedCityState {}
class InterestedCityErrorState extends InterestedCityState {
  final String errorMessage;
  InterestedCityErrorState(this.errorMessage);
}
class InterestedCitySuccessState extends InterestedCityState {
  final List<InterestedCity> cities;
  InterestedCitySuccessState(this.cities);
}
