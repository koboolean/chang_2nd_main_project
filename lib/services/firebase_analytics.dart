import 'package:firebase_analytics/firebase_analytics.dart';

/// SignUp Or SignIn
void signUpAnalyticsLog90(uid) async{
  await FirebaseAnalytics.instance.logSignUp(signUpMethod: uid);
}

/// Item Click Event
void firebaseAnalyticsLog(uid, item) async{
  await FirebaseAnalytics.instance.logSelectItem(itemListId: uid, itemListName: item);
}
/// Screen Change Event
void firebaseScreenViewChanged(uid, screenNm) async{
  await FirebaseAnalytics.instance.logScreenView(screenClass : uid, screenName: screenNm);
}