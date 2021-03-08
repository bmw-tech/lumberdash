import 'package:lumberdash/lumberdash.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_analytics/firebase_analytics.dart';

/// [LumberdashClient] that sends your logs to Firebase Analytics
class FirebaseLumberdash extends LumberdashClient {
  final FirebaseAnalytics firebaseAnalyticsClient;
  final String releaseVersion;
  final String environment;

  /// Instantiates a [LumberdashClient] with a [FirebaseAnalytics]
  /// client, [releaseVersion] and [environment], all parameters
  /// used by the [FirebaseAnalytics] client when sending a log.
  FirebaseLumberdash({
    required this.firebaseAnalyticsClient,
    required this.releaseVersion,
    required this.environment,
  });

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] client
  @override
  void logMessage(String message, [Map<String, String>? extras]) {
    firebaseAnalyticsClient.logEvent(
      name: message,
      parameters: _buildParameters('MESSAGE', extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// warning.
  @override
  void logWarning(String message, [Map<String, String>? extras]) {
    firebaseAnalyticsClient.logEvent(
      name: message,
      parameters: _buildParameters('WARNING', extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// fatal.
  @override
  void logFatal(String message, [Map<String, String>? extras]) {
    firebaseAnalyticsClient.logEvent(
      name: message,
      parameters: _buildParameters('FATAL', extras),
    );
  }

  /// Sends a log to Firebase Analytics using the given [FirebaseAnalytics] with level
  /// error.
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    firebaseAnalyticsClient.logEvent(
      name: exception?.toString() ?? 'firebase_lumberdash_error',
      parameters: _buildParameters('ERROR', {'stacktrace': stacktrace}),
    );
  }

  Map<String, String?> _buildParameters(
    String logLevel,
    Map<String, String?>? extras,
  ) {
    Map<String, String?> parameters = {
      'environment': environment,
      'release': releaseVersion,
      'level': logLevel,
    };
    if (extras != null) {
      parameters.addAll(extras);
    }
    return parameters;
  }
}
