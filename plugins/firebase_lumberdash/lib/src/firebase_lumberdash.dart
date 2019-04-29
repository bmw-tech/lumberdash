import 'package:lumberdash/lumberdash.dart';
import 'package:meta/meta.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// [LumberdashClient] that sends your logs to Firebase Analytics
class FirebaseLumberdash extends LumberdashClient {
  final FirebaseAnalytics firebaseAnalyticsClient;
  final String loggerName;
  final String releaseVersion;
  final String environment;

  /// Instantiates a [LumberdashClient] with a [FirebaseAnalytics] client,
  /// [loggerName], [releaseVersion] and [environment], all parameters
  /// used by the [FirebaseAnalytics] client when sending a log.
  FirebaseLumberdash({
    @required this.firebaseAnalyticsClient,
    @required this.loggerName,
    @required this.releaseVersion,
    @required this.environment,
  })  : assert(firebaseAnalyticsClient != null),
        assert(loggerName != null),
        assert(releaseVersion != null),
        assert(environment != null);

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] client
  @override
  void logMessage(String message, [Map<String, dynamic> extras]) {
    firebaseAnalyticsClient.logEvent(
      name: loggerName,
      parameters: {
        'environment': environment,
        'release': releaseVersion,
        'level': 'message',
        'message': message,
      }..addAll(extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// [warning]
  @override
  void logWarning(String message, [Map<String, dynamic> extras]) {
    firebaseAnalyticsClient.logEvent(
      name: loggerName,
      parameters: {
        'environment': environment,
        'release': releaseVersion,
        'level': 'warning',
      }..addAll(extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// [fatal]
  @override
  void logFatal(String message, [Map<String, dynamic> extras]) {
    firebaseAnalyticsClient.logEvent(
      name: loggerName,
      parameters: {
        'environment': environment,
        'release': releaseVersion,
        'level': 'fatal',
      }..addAll(extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// [error]
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    print(
      'logEvent name: $loggerName, environment: $environment, release: $releaseVersion, exception: $exception, stacktrace $stacktrace',
    );
    firebaseAnalyticsClient.logEvent(
      name: loggerName,
      parameters: {
        'environment': environment,
        'release': releaseVersion,
        'level': 'error',
        'exception': exception,
        'stracktrace': stacktrace,
      },
    );
  }
}
