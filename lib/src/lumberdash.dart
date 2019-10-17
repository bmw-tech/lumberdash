import 'package:meta/meta.dart';

import 'client/client.dart';

/// Initialize the `lumberdashClients` internally
List<LumberdashClient> _lumberdashClients = [];

/// As it name says, it puts Lumberdash to work by setting up its
/// [LumberdashClient]. The full power of Lumberdash can
/// be achieved when you use a custom [LumberdashClient], or multiple
/// clients, that can fit your logging requirements.
putLumberdashToWork({@required List<LumberdashClient> withClients}) {
  assert(withClients != null);
  _lumberdashClients = withClients;
}

/// It calls the `logMessage` method of the each [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
String logMessage(String message, [Map<String, dynamic> extras]) {
  // _lumberdashClient.logMessage(message, extras);
  _lumberdashClients.forEach((c) => c.logMessage(message, extras));
  return message;
}

/// It calls the `logWarning` method of the each [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
String logWarning(String message, [Map<String, dynamic> extras]) {
  _lumberdashClients.forEach((c) => c.logWarning(message, extras));
  return message;
}

/// It calls the `logFatal` method of the each [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
String logFatal(String message, [Map<String, dynamic> extras]) {
  _lumberdashClients.forEach((c) => c.logFatal(message, extras));
  return message;
}

/// It calls the `logError` method of the each [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `exception`.
dynamic logError(dynamic exception, [dynamic stacktrace]) {
  _lumberdashClients.forEach((c) => c.logError(exception, stacktrace));
  return exception;
}
