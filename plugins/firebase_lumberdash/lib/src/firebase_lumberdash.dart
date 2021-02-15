import 'package:lumberdash/lumberdash.dart';
import 'package:meta/meta.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// [LumberdashClient] that sends your logs to Firebase Analytics
class FirebaseLumberdash extends LumberdashClient {
  final FirebaseAnalytics firebaseAnalyticsClient;
  final String releaseVersion;
  final String environment;
  final String loggerName;

  /// Instantiates a [LumberdashClient] with a [FirebaseAnalytics]
  ///[loggerName], [releaseVersion] and [environment], all parameters
  /// used by the [FirebaseAnalytics] client when sending a log.
  FirebaseLumberdash(
      {@required this.firebaseAnalyticsClient,
      @required this.releaseVersion,
      @required this.environment,
      @required this.loggerName})
      : assert(firebaseAnalyticsClient != null),
        assert(releaseVersion != null),
        assert(environment != null),
        assert(loggerName != null);

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] client
  @override
  void logMessage(String message, [Map<String, String> extras]) {
    firebaseAnalyticsClient.logEvent(
      name: this.loggerName,
      parameters: _buildParameters('MESSAGE', message, extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// warning.
  @override
  void logWarning(String message, [Map<String, String> extras]) {
    firebaseAnalyticsClient.logEvent(
      name: this.loggerName,
      parameters: _buildParameters('WARNING', message, extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// fatal.
  @override
  void logFatal(String message, [Map<String, String> extras]) {
    firebaseAnalyticsClient.logEvent(
      name: this.loggerName,
      parameters: _buildParameters('FATAL', message, extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// error.
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    String message = exception?.toString() ?? 'firebase_lumberdash_error';
    firebaseAnalyticsClient.logEvent(
      name: this.loggerName,
      parameters:
          _buildParameters('ERROR', message, {'stacktrace': stacktrace}),
    );
  }

  Map<String, String> _buildParameters(
    String logLevel,
    String message,
    Map<String, String> extras,
  ) {
    Map<String, String> parameters = {
      'environment': environment,
      'release': releaseVersion,
      'level': logLevel,
      'message': message
    };
    if (extras != null) {
      parameters.addAll(extras);
    }
    return parameters;
  }
}
