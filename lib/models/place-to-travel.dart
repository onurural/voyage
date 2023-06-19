// ignore_for_file: file_names

import 'package:voyage/models/photos.dart';

class PlaceToTravel {
  String? formattedAddress;
  String? name;
  List<Photos>? photos;
  String? placeId;
  double? rating;
  String? reference;
  int? userRatingsTotal;

  PlaceToTravel(
      {this.formattedAddress,
      this.name,
      this.photos,
      this.placeId,
      this.rating,
      this.reference,
      this.userRatingsTotal});

  PlaceToTravel.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    name = json['name'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    rating = (json['rating'] as num).toDouble();
    reference = json['reference'];
    userRatingsTotal = json['user_ratings_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatted_address'] = formattedAddress;
    data['name'] = name;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = placeId;
    data['rating'] = rating;
    data['reference'] = reference;
    data['user_ratings_total'] = userRatingsTotal;
    return data;
  }
}


