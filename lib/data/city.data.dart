import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voyage/repository/city.repository.dart';

class CityData implements CityRepository {
  @override
  Future<List<String>> fetchCities(String query) async {
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
      return cityData.map((city) => city['name'] as String).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}