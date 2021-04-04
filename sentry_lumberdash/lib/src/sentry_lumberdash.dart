import 'package:lumberdash/lumberdash.dart';
import 'package:sentry/sentry.dart';

/// [LumberdashClient] that sends your logs to Sentry.
/// Logs are captured as a [Breadcrumb] and exceptions are captured
/// with [Sentry.captureException].
///
/// To use this client, Sentry must be initialized according to
/// [sentry-dart](https://pub.dev/packages/sentry) or
/// [sentry-flutter](https://pub.dev/packages/sentry_flutter).
/// This [SentryLumberdash] then uses the correct Sentry configuration.
class SentryLumberdash extends LumberdashClient {
  SentryLumberdash({Hub? hub}) : _hub = hub ?? Sentry.currentHub;

  Hub _hub;

  /// Sends a breadcrumb to Sentry with level [SentryLevel.info]
  @override
  void logMessage(String message, [Map<String, String>? extras]) {
    _hub.addBreadcrumb(
      Breadcrumb(
        level: SentryLevel.info,
        message: message,
        data: extras,
      ),
    );
  }

  /// Sends a breadcrumb to Sentry with level [SentryLevel.warning]
  @override
  void logWarning(String message, [Map<String, String>? extras]) {
    _hub.addBreadcrumb(
      Breadcrumb(
        level: SentryLevel.warning,
        message: message,
        data: extras,
      ),
    );
  }

  /// Sends a breadcrumb to Sentry with level [SentryLevel.fatal]
  @override
  void logFatal(String message, [Map<String, String>? extras]) {
    _hub.addBreadcrumb(
      Breadcrumb(
        level: SentryLevel.fatal,
        message: message,
        data: extras,
      ),
    );
  }

  /// Sends a crash report ([exception] and [stacktrace]) to Sentry
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    _hub.captureException(exception, stackTrace: stacktrace);
  }
}
