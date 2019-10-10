import 'package:meta/meta.dart';

import 'client/client.dart';

/// Initialize the `lumberdashClient` internally
LumberdashClient _lumberdashClient = SimpleClient();

/// Get the instance of the given [LumberdashClient]
LumberdashClient get lumberdashClient => _lumberdashClient;

/// As it name says, it puts Lumberdash to work by setting up its
/// [LumberdashClient]. With this library you could use [SimpleClient]
/// to start logging on stoudt, but the full power of Lumberdash can
/// be achieved when you use a custom [LumberdashClient] that fits
/// your logging requirements.
putLumberdashToWork({@required LumberdashClient withClient}) {
  assert(withClient != null);
  _lumberdashClient = withClient;
}

/// It calls the `logMessage` method of the given [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
String logMessage(String message, [Map<String, dynamic> extras, String eventName]) {
  _lumberdashClient.logMessage(message, extras, eventName);
  return message;
}

/// It calls the `logWarning` method of the given [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
String logWarning(String message, [Map<String, dynamic> extras, String eventName]) {
  _lumberdashClient.logWarning(message, extras, eventName);
  return message;
}

/// It calls the `logFatal` method of the given [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
String logFatal(String message, [Map<String, dynamic> extras, String eventName]) {
  _lumberdashClient.logFatal(message, extras, eventName);
  return message;
}

/// It calls the `logError` method of the given [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `exception`.
dynamic logError(dynamic exception, [dynamic stacktrace, String eventName]) {
  _lumberdashClient.logError(exception, stacktrace, eventName);
  return exception;
}
