import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:voyage/models/place.dart';

class Analytics {
    static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: _analytics);

     Future<void> sendAnalyticsPlaceViewEvent(Place place) async {
      await _analytics.logEvent(
      name: 'place_visited',
      parameters: null,
    );
  }


}