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
      this.reviews});

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
    image = json['image'] != null ? new PlaceImage.fromJson(json['image']) : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['formatted_adress'] = this.formattedAdress;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['icon'] = this.icon;
    data['photo_reference'] = this.photoReference;
    data['placeId'] = this.placeId;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.addressComponent != null) {
      data['address_component'] =
          this.addressComponent!.map((v) => v.toJson()).toList();
    }
    data['formatted_address'] = this.formattedAddress;
    data['rating'] = this.rating;
    data['user_ratings_total'] = this.userRatingsTotal;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Location.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Location.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast!.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest!.toJson();
    }
    return data;
  }
}

class PlaceImage {
  String? image;
  String? contentType;

  PlaceImage({this.image, this.contentType});

  PlaceImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['contentType'] = this.contentType;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this.longName;
    data['short_name'] = this.shortName;
    data['types'] = this.types;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_name'] = this.authorName;
    data['author_url'] = this.authorUrl;
    data['language'] = this.language;
    data['original_language'] = this.originalLanguage;
    data['profile_photo_url'] = this.profilePhotoUrl;
    data['rating'] = this.rating;
    data['relative_time_description'] = this.relativeTimeDescription;
    data['text'] = this.text;
    data['time'] = this.time;
    data['translated'] = this.translated;
    return data;
  }
}
