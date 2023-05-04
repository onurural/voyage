import 'dart:convert';
import 'package:http/http.dart' as http;

 abstract class CityRepository {
  Future<List<String>> fetchCities(String query);
}