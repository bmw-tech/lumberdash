import 'package:lumberdash/lumberdash.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_lumberdash/firebase_lumberdash.dart';

void main() {
  putLumberdashToWork(withClients: [
    FirebaseLumberdash(
      firebaseAnalyticsClient: FirebaseAnalytics(),
      loggerName: 'FirebaseLumberdash',
      environment: 'development',
      releaseVersion: '1.0.0',
    ),
  ]);
  logWarning('Hello Warning');
  logFatal('Hello Fatal!');
  logMessage('Hello Message!');
  logError(Exception('Hello Error'));
}
