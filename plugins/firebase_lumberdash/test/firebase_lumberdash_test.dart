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

    group('initialization', () {
      test('throws AssertionError when firebaseAnalyticsClient is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: null,
            loggerName: loggerName,
            releaseVersion: releaseVersion,
            environment: environment,
          );
        } catch (error) {
          expect(error, isAssertionError);
        }
      });

      test('throws AssertionError when loggerName is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: firebaseAnalytics,
            loggerName: null,
            releaseVersion: releaseVersion,
            environment: environment,
          );
        } catch (error) {
          expect(error, isAssertionError);
        }
      });

      test('throws AssertionError when releaseVersion is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: firebaseAnalytics,
            loggerName: loggerName,
            releaseVersion: null,
            environment: environment,
          );
        } catch (error) {
          expect(error, isAssertionError);
        }
      });

      test('throws AssertionError when environment is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: firebaseAnalytics,
            loggerName: loggerName,
            releaseVersion: releaseVersion,
            environment: null,
          );
        } catch (error) {
          expect(error, isAssertionError);
        }
      });
    });

    test('logMessage w/extras', () {
      firebaseLumberdash.logMessage(message, extras);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'message',
            'message': message,
            'extras': extras.toString(),
          },
        ),
      ).called(1);
    });

    test('logMessage w/out extras', () {
      firebaseLumberdash.logMessage(message, null);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'message',
            'message': message,
            'extras': '',
          },
        ),
      ).called(1);
    });

    test('logError w/stacktrace', () {
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
            'stacktrace': stacktrace,
          },
        ),
      ).called(1);
    });

    test('logError w/out stacktrace', () {
      final String exception = 'test-exception';
      firebaseLumberdash.logError(exception, null);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'error',
            'exception': exception,
            'stacktrace': '',
          },
        ),
      ).called(1);
    });

    test('logFatal w/extras', () {
      firebaseLumberdash.logFatal(message, extras);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'fatal',
            'message': message,
            'extras': extras.toString(),
          },
        ),
      ).called(1);
    });

    test('logFatal w/out extras', () {
      firebaseLumberdash.logFatal(message, null);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'fatal',
            'message': message,
            'extras': '',
          },
        ),
      ).called(1);
    });

    test('logWarning w/extras', () {
      firebaseLumberdash.logWarning(message, extras);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'warning',
            'message': message,
            'extras': extras.toString(),
          },
        ),
      ).called(1);
    });

    test('logWarning w/out extras', () {
      firebaseLumberdash.logWarning(message, null);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'warning',
            'message': message,
            'extras': '',
          },
        ),
      ).called(1);
    });
  });
}
