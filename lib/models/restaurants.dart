class Restaurant {
  String? formattedAddress;
  String? name;
  bool? openNow;
  List<Photos>? photos;
  String? placeId;
  int? priceLevel;
  double? rating;
  String? reference;
  int? userRatingsTotal;

  Restaurant(
      {this.formattedAddress,
      this.name,
      this.openNow,
      this.photos,
      this.placeId,
      this.priceLevel,
      this.rating,
      this.reference,
      this.userRatingsTotal});

  Restaurant.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    name = json['name'];
    openNow = json['open_now'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    priceLevel = json['price_level'];
    rating = (json['rating'] as num).toDouble();
    reference = json['reference'];
    userRatingsTotal = json['user_ratings_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatted_address'] = formattedAddress;
    data['name'] = name;
    data['open_now'] = openNow;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = placeId;
    data['price_level'] = priceLevel;
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
