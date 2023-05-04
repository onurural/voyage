import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CityProvider with ChangeNotifier {
  List<String> _cities = [];


  List<String> get cities => _cities;

  Future<void> fetchCities(String query) async {
    final apiKey = '48d84f3ef5msh886f23848ca2383p1b7a13jsnd16b3aad5029';
    final url =
        'https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=$query&sort=name&limit=10';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> cityData = data['data'];
      _cities = cityData.map((city) => city['name'] as String).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}