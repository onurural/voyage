import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/place.dart';


abstract class PlaceRepository {
  Future<List<Place>> fetchPlace();
}

class PlaceRepo extends PlaceRepository {
  final place = Place();

  @override
  Future<List<Place>> fetchPlace() async {
    var url = Uri.https('service1-dot-voyage-368821.lm.r.appspot.com', '/place');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Place> places = data.map((json) => Place.fromJson(json)).toList();
      print('Place: ${places[0].name}');
      return places;
    } else {
    throw Exception('Failed to load album');
    }
  }
}