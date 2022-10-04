import 'package:firebase_analytics/firebase_analytics.dart';

/// SignUp
void signUpAnalyticsLog(String uid) async{
  await FirebaseAnalytics.instance.logSignUp(signUpMethod: uid);
}

/// LogIn
void loginAnalyticsLog(String uid) async{
  await FirebaseAnalytics.instance.logLogin(loginMethod: uid);
}

/// Item Click Event
void firebaseAnalyticsLog(String uid, String item) async{
  await FirebaseAnalytics.instance.logSelectItem(itemListId: uid, itemListName: item);
}
/// Screen Change Event
void firebaseScreenViewChanged(String uid, String screenNm) async{
  await FirebaseAnalytics.instance.logScreenView(screenClass : uid, screenName: screenNm);
}