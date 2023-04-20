import 'dart:convert';

import 'package:voyage/models/place.dart';
import 'package:voyage/repository/place.repository.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';




class PlaceData extends PlaceRepository {
  final logger = Logger('Http Service Logger');
  final place = Place();

  @override
  Future<List<Place>> fetchPlace() async {
    List<Place> places = [];
    try {
      var url = Uri.https('service1-dot-voyage-368821.lm.r.appspot.com', '/place');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body); 
        places = data.map((json) => Place.fromJson(json)).toList();
        return places;
      } 
      return places;
    } catch (e) {
      logger.severe(e.toString());
      rethrow;
    }
  }
  // TODO: Add Cache mechanism to optimize the http requests.
  @override
  Future<List<Place>> fetchPlaceByCategory(String category) async {
    var url = Uri.https('service1-dot-voyage-368821.lm.r.appspot.com', '/place/category', {'name': category});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Place> places = data.map((json) => Place.fromJson(json)).toList();
      return places;
    } else {
    throw Exception('Failed to load places by category $category');
    }
  }
}