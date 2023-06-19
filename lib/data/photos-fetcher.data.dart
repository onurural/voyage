// Implement the repository interface.
import 'dart:convert';

import 'package:voyage/repository/photos-fetcher-repository.dart';
import 'package:http/http.dart' as http;
class PhotosFetcherData implements PhotosFetcherRepository {
  String apiKey='AIzaSyBwUfNX77fGSlKtOj7jUBxiiXEvcf0hAbU';
  @override
  Future<List<String>> fetchImages(String placeId) async {

    List<String> photoReferences = await _fetchPhotoReferences(placeId);


    List<String> photoUrls = [];
    for (var photoReference in photoReferences) {
      photoUrls.add(_buildPhotoUrl(photoReference));
    }

    return photoUrls;
  }



  Future<List<String>> _fetchPhotoReferences(String placeId) async {
    final response = await http.get(
        Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=photos&key=$apiKey'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var photos = data['result']['photos'] as List;
      return photos.take(5).map((photo) => photo['photo_reference'].toString()).toList();
    } else {
      throw Exception('Failed to load photo references');
    }
  }

  String _buildPhotoUrl(String photoReference) {
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
  }
}