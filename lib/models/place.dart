import 'dart:convert';
import 'dart:typed_data';

class Place {
  String? sId;
  String? name;
  String? formattedAdress;
  Geometry? geometry;
  String? icon;
  String? photoReference;
  String? placeId;
  PlaceImage? image;
  List<AddressComponent>? addressComponent;
  String? formattedAddress;
  double? rating;
  int? userRatingsTotal;
  List<Reviews>? reviews;
  String? category;

  Place(
      {this.sId,
      this.name,
      this.formattedAdress,
      this.geometry,
      this.icon,
      this.photoReference,
      this.placeId,
      this.image,
      this.addressComponent,
      this.formattedAddress,
      this.rating,
      this.userRatingsTotal,
      this.reviews,
      this.category});

  Place.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    formattedAdress = json['formatted_adress'];
    geometry = json['geometry'] != null
        ? Geometry.fromJson(json['geometry'])
        : null;
    icon = json['icon'];
    photoReference = json['photo_reference'];
    placeId = json['placeId'];
    image = json['image'] != null ?  PlaceImage.fromJson(json['image']) : null;
    if (json['address_component'] != null) {
      addressComponent = <AddressComponent>[];
      json['address_component'].forEach((v) {
        addressComponent!.add(AddressComponent.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    rating = json['rating'];
    userRatingsTotal = json['user_ratings_total'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['formatted_adress'] = formattedAdress;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['icon'] = icon;
    data['photo_reference'] = photoReference;
    data['placeId'] = placeId;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (addressComponent != null) {
      data['address_component'] =
          addressComponent!.map((v) => v.toJson()).toList();
    }
    data['formatted_address'] = formattedAddress;
    data['rating'] = rating;
    data['user_ratings_total'] = userRatingsTotal;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['category'] = category;
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? Viewport.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (viewport != null) {
      data['viewport'] = viewport!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? Location.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? Location.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
    }
    return data;
  }
}

class PlaceImage {
  Uint8List? image;
  String? contentType;

  PlaceImage({this.image, this.contentType});

  PlaceImage.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? Uint8List.fromList(base64.decode(json['image'])) : null;
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['contentType'] = contentType;
    return data;
  }
}

class AddressComponent {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponent({this.longName, this.shortName, this.types});

  AddressComponent.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}

class Reviews {
  String? authorName;
  String? authorUrl;
  String? language;
  String? originalLanguage;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;
  bool? translated;

  Reviews(
      {this.authorName,
      this.authorUrl,
      this.language,
      this.originalLanguage,
      this.profilePhotoUrl,
      this.rating,
      this.relativeTimeDescription,
      this.text,
      this.time,
      this.translated});

  Reviews.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    authorUrl = json['author_url'];
    language = json['language'];
    originalLanguage = json['original_language'];
    profilePhotoUrl = json['profile_photo_url'];
    rating = json['rating'];
    relativeTimeDescription = json['relative_time_description'];
    text = json['text'];
    time = json['time'];
    translated = json['translated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author_name'] = authorName;
    data['author_url'] = authorUrl;
    data['language'] = language;
    data['original_language'] = originalLanguage;
    data['profile_photo_url'] = profilePhotoUrl;
    data['rating'] = rating;
    data['relative_time_description'] = relativeTimeDescription;
    data['text'] = text;
    data['time'] = time;
    data['translated'] = translated;
    return data;
  }
}