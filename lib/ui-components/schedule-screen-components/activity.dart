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
  List? photos;
  String? placeID;
  Duration? duration;

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
  }) : id = idCounter++;
}