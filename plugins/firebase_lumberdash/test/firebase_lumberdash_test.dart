import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_lumberdash/firebase_lumberdash.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

main() {
  group('Firebase Lumberdash', () {
    MockFirebaseAnalytics firebaseAnalytics;
    FirebaseLumberdash firebaseLumberdash;
    String loggerName = 'FirebaseLumberdashLogger';
    String releaseVersion = '1.0.0';
    String environment = 'development';
    String message = 'test-message';
    Map<String, dynamic> extras = {
      'foo': 'bar',
      'test': [0, 1, 2],
    };

    setUp(() {
      firebaseAnalytics = MockFirebaseAnalytics();
      firebaseLumberdash = FirebaseLumberdash(
        firebaseAnalyticsClient: firebaseAnalytics,
        loggerName: loggerName,
        releaseVersion: releaseVersion,
        environment: environment,
      );
    });

    test('logMessage', () {
      firebaseLumberdash.logMessage(message, extras);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: extras
            ..addAll(
              {
                'environment': environment,
                'release': releaseVersion,
                'level': 'message',
                'message': message,
              },
            ),
        ),
      ).called(1);
    });

    test('logError', () {
      final String exception = 'test-exception';
      final String stacktrace = 'test-stacktrace';
      firebaseLumberdash.logError(exception, stacktrace);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'error',
            'exception': exception,
            'stracktrace': stacktrace,
          },
        ),
      ).called(1);
    });

    test('logFatal', () {
      firebaseLumberdash.logFatal(message, extras);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: extras
            ..addAll(
              {
                'environment': environment,
                'release': releaseVersion,
                'level': 'fatal',
              },
            ),
        ),
      ).called(1);
    });

    test('logWarning', () {
      firebaseLumberdash.logWarning(message, extras);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: extras
            ..addAll(
              {
                'environment': environment,
                'release': releaseVersion,
                'level': 'warning',
              },
            ),
        ),
      ).called(1);
    });
  });
}
