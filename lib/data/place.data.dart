// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:voyage/utility/category.enum.dart';
import 'package:voyage/models/place.dart';
import 'package:voyage/repository/place.repository.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:voyage/utility/page.enum.dart';

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

  final pages = [6, 12, 18, 24, 30, 36, 42, 48];
  var _lastPageNumber = -1;
  final categories = ['Historic', 'Natural', 'City Vibes', 'Rural', 'Mediterrain'];

  @override
  Future<List<Place>> fetchPlace(Page pageNumber) async {
    
    if (_lastPageNumber != pageNumber.index) {
      var newPlaces = await _fetchPlaceFromServer(pageNumber);
     places.addAll(newPlaces);
    }
    _lastPageNumber = pageNumber.index;
    return places;
  }

  Future<List<Place>> _fetchPlaceFromServer(Page pageNumber) async {
    try {
        var url = Uri.https(apiURL, placeEndpoint, {'page' : '${pages[pageNumber.index]}'});
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
  Future<List<Place>> fetchPlaceByCategory(CATEGORY category, Page pageNumber) async {
    var selectedCategory = categories[category.index];
    
    Uri url = Uri.https(apiURL, '$placeEndpoint$categoryEndpoint', {
      'name': selectedCategory,
      'page': '${pageNumber.index}'
    });
    
    var newPlace = await _fetchPlaceByCategoryFromServer(url);
        
    switch (category) {
      case CATEGORY.historic:
      historicPlaces.addAll(newPlace);
      return historicPlaces;
        
      case CATEGORY.rural:
        ruralPlaces.addAll(newPlace);
        return ruralPlaces;

      case CATEGORY.natural:
        naturalPlaces.addAll(newPlace);
        return naturalPlaces;

      case CATEGORY.cityVibes:
      cityVibesPlaces.addAll(newPlace);
        return cityVibesPlaces;

      case CATEGORY.mediterrain:
       mediterrainPlaces.addAll(newPlace);
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
