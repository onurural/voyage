import 'package:voyage/ui-components/home-view-components/Place.dart';

import 'Activity.dart';

class Schedule {
  final List<Activity> activities;
  final Place place;
  final title = "Schedule";

  Schedule(this.activities, this.place);
}
