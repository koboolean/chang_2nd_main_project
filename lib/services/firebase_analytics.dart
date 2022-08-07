import 'package:firebase_analytics/firebase_analytics.dart';

/// SignUp
void signUpAnalyticsLog(uid) async{
  await FirebaseAnalytics.instance.logSignUp(signUpMethod: uid);
}

/// LogIn
void loginAnalyticsLog(uid) async{
  await FirebaseAnalytics.instance.logLogin(loginMethod: uid);
}

/// Item Click Event
void firebaseAnalyticsLog(uid, item) async{
  await FirebaseAnalytics.instance.logSelectItem(itemListId: uid, itemListName: item);
}
/// Screen Change Event
void firebaseScreenViewChanged(uid, screenNm) async{
  await FirebaseAnalytics.instance.logScreenView(screenClass : uid, screenName: screenNm);
}