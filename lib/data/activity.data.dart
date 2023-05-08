import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:voyage/models/entertainment.dart';
import 'package:voyage/models/place-to-travel.dart';
import 'package:voyage/models/restaurants.dart';
import 'package:voyage/repository/activity.repository.dart';
import 'package:voyage/utility/constants.dart';
import 'package:http/http.dart' as http;
import 'package:voyage/utility/min-price.enum.dart';

class ActivityData implements ActivityRepository {
  final _entertainmentEndpoint = activityEndpoint + entertainmentEndpoint;
  final _restaurantEndpoint = activityEndpoint + restaurantsEndpoint;
  final _placeToTravelEndpoint = activityEndpoint + placesToTravelEndpoint;
  final _cityQueryParam = 'city';
  @override
  Future<List<Entertainment>> findEntertainment({required String city, required Price minPrice, required Price maxPrice}) async{
    
    try {
      var url = Uri.https(apiURL, _entertainmentEndpoint, {_cityQueryParam: city});
      final response = await http.get(url);
      if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            List<dynamic> data = json.decode(response.body);
            List<Entertainment> entertainments = data.map((json) => Entertainment.fromJson(json)).toList();
            return entertainments;
          }
      }
      throw HttpException('Unexpected status code: ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<PlaceToTravel>> findPlaceToTravel({required String city}) async {    
    try {
      var url = Uri.https(apiURL, _placeToTravelEndpoint, {_cityQueryParam: city});
      final response = await http.get(url);
      if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            List<dynamic> data = json.decode(response.body);
            List<PlaceToTravel> placesToTravel = data.map((json) => PlaceToTravel.fromJson(json)).toList();
            return placesToTravel;
          }
      }
      throw HttpException('Unexpected status code: ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Restaurant>> findRestaurants({required String city, required Price minPrice, required Price maxPrice}) async {
     try {
      var url = Uri.https(apiURL, _restaurantEndpoint, {_cityQueryParam: city});
      final response = await http.get(url);
      if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            List<dynamic> data = json.decode(response.body);
            List<Restaurant> restaurants = data.map((json) => Restaurant.fromJson(json)).toList();
            return restaurants;
          }
      }
      throw HttpException('Unexpected status code: ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }


}