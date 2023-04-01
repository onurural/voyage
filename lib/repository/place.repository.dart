import 'package:voyage/models/place.dart';

abstract class PlaceRepository {
  Future<List<Place>> fetchPlace();
}

