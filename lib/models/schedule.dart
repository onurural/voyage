
import 'package:voyage/models/activity.dart';

class Schedule {
  final List<Activity> activities;
  final String userId;
  final String title;

  Schedule(this.activities, this.title, this.userId);

   Map<String, dynamic> toJson() {
    return {
      'activities': activities.map((activity) => activity.toJson()).toList(),
      'userId': userId,
      'title': title,
    };
  }

}
