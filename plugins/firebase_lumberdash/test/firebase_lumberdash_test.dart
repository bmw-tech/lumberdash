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
    Map<String, String> extras = {
      'foo': 'bar',
      'test': 'passed',
    };

    setUp(() {
      firebaseAnalytics = MockFirebaseAnalytics();
      firebaseLumberdash = FirebaseLumberdash(
        firebaseAnalyticsClient: firebaseAnalytics,
        releaseVersion: releaseVersion,
        environment: environment,
      );
    });

    group('initialization', () {
      test('throws AssertionError when firebaseAnalyticsClient is null', () {
        try {
          FirebaseLumberdash(
            firebaseAnalyticsClient: null,
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
            releaseVersion: releaseVersion,
            environment: null,
          );
        } catch (error) {
          expect(error, isAssertionError);
        }
      });
    });

    test('logMessage w/extras', () {
      firebaseLumberdash.logMessage('myMessage', extras);
      verify(
        firebaseAnalytics.logEvent(
          name: 'myMessage',
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'MESSAGE',
            'foo': 'bar',
            'test': 'passed',
          },
        ),
      ).called(1);
    });

    test('logMessage w/out extras', () {
      firebaseLumberdash.logMessage('myMessage', null);
      verify(
        firebaseAnalytics.logEvent(
          name: 'myMessage',
          parameters: {
            'environment': environment,
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
          name: exception,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'ERROR',
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
          name: exception,
          parameters: {
            'environment': environment,
            'release': releaseVersion,
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
          name: 'myFatal',
          parameters: {
            'environment': environment,
            'release': releaseVersion,
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
          name: 'myFatal',
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'FATAL',
          },
        ),
      ).called(1);
    });

    test('logWarning w/extras', () {
      firebaseLumberdash.logWarning('myWarning', extras);
      verify(
        firebaseAnalytics.logEvent(
          name: 'myWarning',
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'WARNING',
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
          name: 'myWarning',
          parameters: {
            'environment': environment,
            'release': releaseVersion,
            'level': 'WARNING',
          },
        ),
      ).called(1);
    });
  });
}
