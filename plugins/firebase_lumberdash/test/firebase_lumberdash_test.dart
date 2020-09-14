import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_lumberdash/firebase_lumberdash.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

main() {
  group('Firebase Lumberdash', () {
    MockFirebaseAnalytics firebaseAnalytics;
    FirebaseLumberdash firebaseLumberdash;
    String releaseVersion = '1.0.0';
    String environment = 'development';
    String loggerName = 'FirebaseLumberdashLogger';
    Map<String, String> extras = {
      'foo': 'bar',
      'test': 'passed',
    };
    String message = 'test-message';

    setUp(() {
      firebaseAnalytics = MockFirebaseAnalytics();
      firebaseLumberdash = FirebaseLumberdash(
        firebaseAnalyticsClient: firebaseAnalytics,
        releaseVersion: releaseVersion,
        environment: environment,
        loggerName: loggerName,
      );
    });

    group('initialization', () {
      test('throws AssertionError when firebaseAnalyticsClient is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: null,
            releaseVersion: releaseVersion,
            environment: environment,
            loggerName: loggerName,
          );
        } catch (error) {
          expect(error, isAssertionError);
        }
      });

      test('throws AssertionError when releaseVersion is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: firebaseAnalytics,
            releaseVersion: null,
            environment: environment,
            loggerName: loggerName,
          );
        } catch (error) {
          expect(error, isAssertionError);
        }
      });

      test('throws AssertionError when environment is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: firebaseAnalytics,
            releaseVersion: releaseVersion,
            environment: null,
            loggerName: loggerName,
          );
        } catch (error) {
          expect(error, isAssertionError);
        }
      });

      test('throws AssertionError when loggerName is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: firebaseAnalytics,
            releaseVersion: releaseVersion,
            environment: environment,
            loggerName: null,
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
            'level': 'MESSAGE',
            'message': message,
            'foo': 'bar',
            'test': 'passed',
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
            'message': message,
            'release': releaseVersion,
            'level': 'MESSAGE',
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
            'level': 'ERROR',
            'message': exception,
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
            'message': exception,
            'level': 'ERROR',
            'stacktrace': null,
          },
        ),
      ).called(1);
    });

    test('logFatal w/extras', () {
      firebaseLumberdash.logFatal('myFatal', extras);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'message': 'myFatal',
            'level': 'FATAL',
            'foo': 'bar',
            'test': 'passed',
          },
        ),
      ).called(1);
    });

    test('logFatal w/out extras', () {
      firebaseLumberdash.logFatal('myFatal', null);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'message': 'myFatal',
            'level': 'FATAL',
          },
        ),
      ).called(1);
    });

    test('logWarning w/extras', () {
      firebaseLumberdash.logWarning('myWarning', extras);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'WARNING',
            'message': 'myWarning',
            'foo': 'bar',
            'test': 'passed',
          },
        ),
      ).called(1);
    });

    test('logWarning w/out extras', () {
      firebaseLumberdash.logWarning('myWarning', null);
      verify(
        firebaseAnalytics.logEvent(
          name: loggerName,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'message': 'myWarning',
            'level': 'WARNING',
          },
        ),
      ).called(1);
    });
  });
}
