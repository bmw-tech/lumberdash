import 'package:lumberdash/lumberdash.dart';
import 'package:meta/meta.dart';
import 'package:sentry/sentry.dart';

/// [LumberdashClient] that sends your logs to Sentry
class SentryLumberdash extends LumberdashClient {
  static const defaultValue = 'SentryLumberdash';

  final SentryClient sentryClient;
  final String loggerName;
  final String releaseVersion;
  final String environment;

  /// Instantiates a [LumberdashClient] with a [SentryClient],
  /// [loggerName], [releaseVersion] and [environment], all parameters
  /// used by the [SentryClient] when sending a log.
  SentryLumberdash({
    @required this.sentryClient,
    @required this.loggerName,
    @required this.releaseVersion,
    @required this.environment,
  })  : assert(sentryClient != null),
        assert(loggerName != null),
        assert(releaseVersion != null),
        assert(environment != null);

  /// Convenience constructor that takes a [dsnKey] for your
  /// [SentryClient] and defaults the values of [loggerName],
  /// [releaseVersion] and [environment].
  factory SentryLumberdash.withDsn({
    @required String dsnKey,
    String loggerName = defaultValue,
    String releaseVersion = defaultValue,
    String environment = defaultValue,
  }) =>
      SentryLumberdash(
        sentryClient: SentryClient(dsn: dsnKey),
        loggerName: loggerName,
        releaseVersion: releaseVersion,
        environment: environment,
      );

  /// Sends a log to Sentry using the given [SentryClient] with level
  /// [SeverityLevel.debug]
  @override
  void logMessage(String message, [Map<String, dynamic> extras]) {
    sentryClient.capture(
        event: Event(
      loggerName: loggerName,
      message: message,
      extra: extras,
      environment: environment,
      release: releaseVersion,
      level: SeverityLevel.debug,
    ));
  }

  /// Sends a log to Sentry using the given [SentryClient] with level
  /// [SeverityLevel.warning]
  @override
  void logWarning(String message, [Map<String, dynamic> extras]) {
    sentryClient.capture(
        event: Event(
      loggerName: loggerName,
      message: message,
      extra: extras,
      environment: environment,
      release: releaseVersion,
      level: SeverityLevel.warning,
    ));
  }

  /// Sends a log to Sentry using the given [SentryClient] with level
  /// [SeverityLevel.fatal]
  @override
  void logFatal(String message, [Map<String, dynamic> extras]) {
    sentryClient.capture(
        event: Event(
      loggerName: loggerName,
      message: message,
      extra: extras,
      environment: environment,
      release: releaseVersion,
      level: SeverityLevel.fatal,
    ));
  }

  /// Sends a crash report ([exception] and [stacktrace]) to Sentry
  /// using the given [SentryClient]
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    sentryClient.captureException(
      exception: exception,
      stackTrace: stacktrace,
    );
  }
}
