import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:voyage/models/autocomplete-prediction.dart';
import 'package:voyage/repository/city.repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CityData implements CityRepository {
  @override
  Future<List<Predictions>?> fetchCities(String query) async {
    var apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

    try {
      var url = Uri.https('maps.googleapis.com', '/maps/api/place/autocomplete/json', 
      {
        'input': query,
        'types': '(cities)',
        'key': apiKey
      });

      final response = await http.get(url);
      if (response.statusCode == 200) {
         if (response.body.isNotEmpty) {
          final Map<String, dynamic> decodedPrediction = json.decode(response.body);
          AutocompletePrediction prediction = AutocompletePrediction.fromJson(decodedPrediction);
          return prediction.predictions;
        }
        return null; 
      }
      throw HttpException('Unexpected status code: ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}