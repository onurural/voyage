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

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['html_attributions'] = htmlAttributions;
    data['photo_reference'] = photoReference;
    data['width'] = width;
    return data;
  }
}
