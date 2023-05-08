
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:voyage/models/interested-city.dart';
import 'package:http/http.dart' as http;
import 'package:voyage/repository/interested-city.repository.dart';
import 'package:voyage/utility/constants.dart';


class InterestedCityData implements InterestedCityRepository {


  static const queryParameter = 'userId';
  

  @override
  Future<List<InterestedCity>> fetchInterestedCities({required String userId}) async {
    var endpoint = userEndpoint + interestedCitiesEndpoint;
    try {
      var url = Uri.https(apiURL, endpoint, {queryParameter: userId});
      final response = await http.get(url);
      if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            List<dynamic> data = json.decode(response.body);
            List<InterestedCity> interestedCities = data.map((json) => InterestedCity.fromJson(json)).toList();
            return interestedCities;
          }
      }
      throw HttpException('Unexpected status code: ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}