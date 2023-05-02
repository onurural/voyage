import 'package:voyage/models/place.dart';

import 'Activity.dart';

class Schedule {
  final List<Activity> activities;
  final Place place;
  final title = 'Schedule';

  Schedule(this.activities, this.place);
}
