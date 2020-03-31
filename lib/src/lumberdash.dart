import 'package:meta/meta.dart';

import 'client/client.dart';

/// Initialize the `lumberdashClients` internally
List<LumberdashClient> _lumberdashClients = [];

/// Whether the app is running in production or development
bool _development = false;

/// As it name says, it puts Lumberdash to work by setting up its
/// [LumberdashClient]. The full power of Lumberdash can
/// be achieved when you use a custom [LumberdashClient], or multiple
/// clients, that can fit your logging requirements.
putLumberdashToWork({@required List<LumberdashClient> withClients, bool development}) {
  assert(withClients != null);
  assert(_development = true);

  _lumberdashClients = withClients;
  _development = development ?? _development;
}

/// It calls the `logMessage` method of the each [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
/// If you want to avoid logging to a particular client that was
/// previously registered in `putLumberdashToWork#withClients`, use
/// `exceptFor` to filter out that client.
String logMessage(
  String message, {
  Map<String, String> extras,
  List<Type> exceptFor: const [],
  bool developmentOnly: false,
}) {
  if(!developmentOnly || (developmentOnly && _development)) {
    _filterOutClientsAndLog(exceptFor, (c) => c.logMessage(message, extras));
  }

  return message;
}

/// It calls the `logWarning` method of the each [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
/// If you want to avoid logging to a particular client that was
/// previously registered in `putLumberdashToWork#withClients`, use
/// `exceptFor` to filter out that client.
String logWarning(
  String message, {
  Map<String, String> extras,
  List<Type> exceptFor: const [],
  bool developmentOnly: false,
}) {
  if(!developmentOnly || (developmentOnly && _development)) {
    _filterOutClientsAndLog(exceptFor, (c) => c.logWarning(message, extras));
  }

  return message;
}

/// It calls the `logFatal` method of the each [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `message`.
/// If you want to avoid logging to a particular client that was
/// previously registered in `putLumberdashToWork#withClients`, use
/// `exceptFor` to filter out that client.
String logFatal(
  String message, {
  Map<String, String> extras,
  List<Type> exceptFor: const [],
  bool developmentOnly: false,
}) {
  if(!developmentOnly || (developmentOnly && _development)) {
    _filterOutClientsAndLog(exceptFor, (c) => c.logFatal(message, extras));
  }

  return message;
}

/// It calls the `logError` method of the each [LumberdashClient]
/// passed to `putLumberdashToWork`, and returns the given `exception`.
/// If you want to avoid logging to a particular client that was
/// previously registered in `putLumberdashToWork#withClients`, use
/// `exceptFor` to filter out that client.
dynamic logError(
  dynamic exception, {
  dynamic stacktrace,
  List<Type> exceptFor: const [],
  bool developmentOnly: false,
}) {
  if(!developmentOnly || (developmentOnly && _development)) {
    _filterOutClientsAndLog(exceptFor, (c) => c.logError(exception, stacktrace));
  }

  return exception;
}

typedef Logger = Function(LumberdashClient client);

void _filterOutClientsAndLog(
  List<Type> clientsToFilterOut,
  Logger logger,
) {
  _lumberdashClients
      .where((client) => !clientsToFilterOut.contains(client.runtimeType))
      .forEach((c) => logger(c));
}
