import 'package:voyage/models/interested-city.dart';

abstract class InterestedCityRepository {
  Future<List<InterestedCity>> fetchInterestedCities({required String userId});
}