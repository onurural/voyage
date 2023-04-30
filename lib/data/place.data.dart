import 'dart:convert';
import 'dart:io';

import 'package:voyage/category.enum.dart';
import 'package:voyage/models/place.dart';
import 'package:voyage/repository/place.repository.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

const apiURL = 'service1-dot-voyage-368821.lm.r.appspot.com';
const placeEndpoint = '/place';
const categoryEndpoint = '/category';

class PlaceData extends PlaceRepository {
  final logger = Logger('Http Service Logger');
  List<Place> places = [];

  List<Place> historicPlaces = [];
  List<Place> ruralPlaces = [];
  List<Place> cityVibesPlaces = [];
  List<Place> naturalPlaces = [];
  List<Place> mediterrainPlaces = [];


  @override
  Future<List<Place>> fetchPlace() async {
    if (places.isEmpty) {
     places = await _fetchPlaceFromServer();
     return places; 
    }
    return places;
  }

  Future<List<Place>> _fetchPlaceFromServer() async {
    try {
        var url = Uri.https(apiURL, placeEndpoint);
        List<dynamic> data = [];
        final response = await http.get(url);
        if (response.statusCode == 200) {
          if(response.body.isNotEmpty) {
           data = json.decode(response.body);
           List<Place> places = data.map((json) => Place.fromJson(json)).toList();
           return places;
          }
          throw Exception('Response body is empty ${response.body}');
        }
        throw HttpException('Unexpected status code : ${response.statusCode}');
      } catch (e) {
        logger.severe(e.toString());
        rethrow;
      }
  }


  @override
  Future<List<Place>> fetchPlaceByCategory(CATEGORY category) async {
    Uri url = Uri();
    switch (category) {
      case CATEGORY.historic:
         url = Uri.https(apiURL,
        '$placeEndpoint$categoryEndpoint', {'name': 'Historic'});
        if (historicPlaces.isEmpty) {
          historicPlaces = await _fetchPlaceByCategoryFromServer(url);
          return historicPlaces;
        }
        return historicPlaces;
      case CATEGORY.rural:
        url = Uri.https(apiURL,
        '$placeEndpoint$categoryEndpoint', {'name': 'Rural'});
        if (ruralPlaces.isEmpty) {
          ruralPlaces = await _fetchPlaceByCategoryFromServer(url);
          return ruralPlaces;
        }
        return ruralPlaces;
      case CATEGORY.natural:
         url = Uri.https(apiURL,
        '$placeEndpoint$categoryEndpoint', {'name': 'Natural'});
        if (naturalPlaces.isEmpty) {
          naturalPlaces = await _fetchPlaceByCategoryFromServer(url);
          return naturalPlaces;
        }
        return naturalPlaces;
      case CATEGORY.cityVibes:
         url = Uri.https(apiURL,
        '$placeEndpoint$categoryEndpoint', {'name': 'City Vibes'});
        if (cityVibesPlaces.isEmpty) {
          cityVibesPlaces = await _fetchPlaceByCategoryFromServer(url);
          return cityVibesPlaces;
        }
        return cityVibesPlaces;
      case CATEGORY.mediterrain:
         url = Uri.https(apiURL,
        '$placeEndpoint$categoryEndpoint', {'name': 'Mediterrain'});
           if (mediterrainPlaces.isEmpty) {
          mediterrainPlaces = await _fetchPlaceByCategoryFromServer(url);
          return mediterrainPlaces;
        }
        return mediterrainPlaces;
      default:
    }
    throw Exception('Enum is not found');
  }

  Future<List<Place>> _fetchPlaceByCategoryFromServer(Uri url) async {
    try {
        List<dynamic> data = [];
        final response = await http.get(url);

        if (response.statusCode == 200) {
          if(response.body.isNotEmpty) {
            data = json.decode(response.body);
            List<Place> places = data.map((json) => Place.fromJson(json)).toList();
            return places;
          }      
        throw Exception('Response body is empty');
        } else {
        throw Exception('Failed to load places by category ');
        }} catch (e) {
        logger.severe(e.toString());
        rethrow;
      }
  }
}
