import 'package:voyage/models/photos.dart';

class Activity {
  static int idCounter = 0;

  int? id;
  DateTime? beginTime;
  DateTime? endTime;
  DateTime? day;
  String? title;
  String? category;
  double? rate;
  String? description;
  List<Photos>? photos;
  String? placeID;
  Duration? duration;
  List<String> photosLinks;


  Activity({
    required this.beginTime,
    required this.endTime,
    required this.day,
    required this.title,
    required this.category,
    required this.rate,
    required this.description,
    required this.photos,
    required this.placeID,
    required this.duration,
    required this.photosLinks
  }) : id = idCounter++;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'beginTime': beginTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'day': day?.toIso8601String(),
      'title': title,
      'category': category,
      'rate': rate,
      'description': description,
      'photos': photos,
      'placeID': placeID,
      'duration': duration?.inSeconds,
    };
  }
}