import 'package:voyage/utility/min-price.enum.dart';

abstract class EntertainmentEvent {}

class FetchEntertainment extends EntertainmentEvent {
  late String city;
  late Price minPrice;
  late Price maxPrice;
  FetchEntertainment({required this.city, required this.minPrice, required this.maxPrice});
}

