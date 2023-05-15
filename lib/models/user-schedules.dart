import 'dart:convert';


class UserSchedule {
    String? id;
    String? userId;
    List<Activity>? activities;
    String? title;
    int? v;

    UserSchedule({
        this.id,
        this.userId,
        this.activities,
        this.title,
        this.v,
    });

    factory UserSchedule.fromRawJson(String str) => UserSchedule.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserSchedule.fromJson(Map<String, dynamic> json) => UserSchedule(
        id: json["_id"],
        userId: json["userId"],
        activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromJson(x))),
        title: json["title"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
        "title": title,
        "__v": v,
    };
}

class Activity {
    int? id;
    DateTime? beginTime;
    DateTime? endTime;
    DateTime? day;
    String? title;
    String? category;
    double? rate;
    String? description;
    List<Photo>? photos;
    String? placeId;
    int? duration;

    Activity({
        this.id,
        this.beginTime,
        this.endTime,
        this.day,
        this.title,
        this.category,
        this.rate,
        this.description,
        this.photos,
        this.placeId,
        this.duration,
    });

    factory Activity.fromRawJson(String str) => Activity.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        beginTime: json["beginTime"] == null ? null : DateTime.parse(json["beginTime"]),
        endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        title: json["title"],
        category: json["category"],
        rate: json["rate"]?.toDouble(),
        description: json["description"],
        photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
        placeId: json["placeID"],
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "beginTime": beginTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "day": day?.toIso8601String(),
        "title": title,
        "category": category,
        "rate": rate,
        "description": description,
        "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "placeID": placeId,
        "duration": duration,
    };
}

class Photo {
    int? height;
    List<String>? htmlAttributions;
    String? photoReference;
    int? width;

    Photo({
        this.height,
        this.htmlAttributions,
        this.photoReference,
        this.width,
    });

    factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions: json["html_attributions"] == null ? [] : List<String>.from(json["html_attributions"]!.map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": htmlAttributions == null ? [] : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
    };
}
