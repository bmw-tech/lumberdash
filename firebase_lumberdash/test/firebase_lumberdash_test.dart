import 'package:lumberdash/lumberdash.dart' show putLumberdashToWork;
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_lumberdash/firebase_lumberdash.dart';
import 'firebase_lumberdash_test.mocks.dart';


@GenerateMocks([FirebaseAnalytics])
main() {
  group('firebase_lumberdash', () {
    late MockFirebaseAnalytics? firebaseAnalytics;
    late FirebaseLumberdash firebaseLumberdash;
    String releaseVersion = '1.0.0';
    String environment = 'development';
    Map<String, String>? extras = {
      'foo': 'bar',
      'test': 'passed',
    };

    setUp(() {
      firebaseAnalytics = MockFirebaseAnalytics();
      firebaseLumberdash = FirebaseLumberdash(
        firebaseAnalyticsClient: firebaseAnalytics!,
        releaseVersion: releaseVersion,
        environment: environment,
      );
      putLumberdashToWork(withClients: [firebaseLumberdash]);
    });

    group('initialization', () {
      test('throws AssertionError when firebaseAnalyticsClient is null', () {
        try {
          final firebaseLumberdash = FirebaseLumberdash(
            firebaseAnalyticsClient: firebaseAnalytics!,
            releaseVersion: releaseVersion,
            environment: environment,
          );

          expect(firebaseLumberdash, isA<FirebaseLumberdash>());
        } catch (error) {
          fail('Shouldnt throw an error');
        }
      });
    });

    group('logMessage', () {
      test('w/extras', () {
        firebaseLumberdash.logMessage('myMessage', extras);
        verify(
          firebaseAnalytics!.logEvent(
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

      test('w/out extras', () {
        firebaseLumberdash.logMessage('myMessage', null);

        verify(
          firebaseAnalytics!.logEvent(
            name: 'myMessage',
            parameters: {
              'environment': environment,
              'release': releaseVersion,
              'level': 'MESSAGE',
            },
          ),
        ).called(1);
      });
    });

    group('logError', () {
      test('w/stacktrace', () {
        final String exception = 'test-exception';
        final String stacktrace = 'test-stacktrace';
        firebaseLumberdash.logError(exception, stacktrace);

        verify(
          firebaseAnalytics!.logEvent(
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

      test('w/out stacktrace', () {
        final String exception = 'test-exception';
        firebaseLumberdash.logError(exception, null);

        verify(
          firebaseAnalytics!.logEvent(
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
    });

    group('logFatal', () {
      test('w/extras', () {
        firebaseLumberdash.logFatal('myFatal', extras);

        verify(
          firebaseAnalytics!.logEvent(
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

      test('w/out extras', () {
        firebaseLumberdash.logFatal('myFatal', null);

        verify(
          firebaseAnalytics!.logEvent(
            name: 'myFatal',
            parameters: {
              'environment': environment,
              'release': releaseVersion,
              'level': 'FATAL',
            },
          ),
        ).called(1);
      });
    });

    group('logWarning', () {
      test('w/extras', () {
        firebaseLumberdash.logWarning('myWarning', extras);

        verify(
          firebaseAnalytics!.logEvent(
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

      test('w/out extras', () {
        firebaseLumberdash.logWarning('myWarning', null);

        verify(
          firebaseAnalytics!.logEvent(
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
  });
}
