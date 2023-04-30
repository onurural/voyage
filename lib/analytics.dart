import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/models/place.dart';

class Analytics {
    static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: _analytics);

    static final authData = AuthData();

     Future<void> sendAnalyticsPlaceViewEvent(Place place) async {
      var userId = authData.getCurrentUserId();
      _analytics.logEvent(
      name: 'clicked_place',
      parameters: {
        'clicked_user_id': userId,
        'place_id' : place.placeId,
        'place_name' : place.name,
        'place_category' : place.category,
      },
    );
  }


}