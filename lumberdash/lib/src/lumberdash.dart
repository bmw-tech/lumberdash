import 'client/client.dart';

/// Possible LogLevels that can be set for a [LumberdashClient].
enum LogLevel { message, warning, fatal, error }

/// For each LogLevel there is a list of [LumberdashClient], that are used 
/// when the corresponding log-method is called.
var _lumberdashClients = { LogLevel.message : [], LogLevel.warning : [], LogLevel.fatal : [], LogLevel.error: [] };

/// As it name says, it puts Lumberdash to work by setting up its
/// [LumberdashClient]. This method adds the clients to all LogLevels.
/// The full power of Lumberdash can be achieved when you use a custom 
/// [LumberdashClient], or multiple clients, that can fit your logging 
/// requirements.
putLumberdashToWork({required List<LumberdashClient> withClients}) {
  withClients.forEach((client) {_lumberdashClients.forEach((_, logLevelClients) {logLevelClients.add(client);});});
}

/// Puts Lumberdash to work by adding a
/// [LumberdashClient] to a List of LogLevels. Only these LogLevels
/// are used for logging to the LumberdashClient.
putLumberdashToWorkByLogLevel({required Map<LumberdashClient, List<LogLevel>> withClients}) {
  withClients.forEach((keyLC, logLevelClients) {logLevelClients.forEach((element) {_lumberdashClients[element]?.add(keyLC);});});
}

/// It calls the `logMessage` method of each [LumberdashClient] of
/// [LogLevel.message], and returns the given `message`.
/// If you want to avoid logging to a particular client that was
/// previously registered, use  `exceptFor` to filter out that client.
String logMessage(
  String message, {
  Map<String, String>? extras,
  List<Type> exceptFor = const [],
}) {
  _filterOutClientsAndLog(exceptFor, (c) => c.logMessage(message, extras), LogLevel.message);
  return message;
}

/// It calls the `logWarning` method of each [LumberdashClient] of 
/// [LogLevel.warning] and returns the given `message`.
/// If you want to avoid logging to a particular client that was
/// previously registered, use `exceptFor` to filter out that client.
String logWarning(
  String message, {
  Map<String, String>? extras,
  List<Type> exceptFor = const [],
}) {
  _filterOutClientsAndLog(exceptFor, (c) => c.logWarning(message, extras), LogLevel.warning);
  return message;
}

/// It calls the `logFatal` method of each [LumberdashClient] of 
/// [LogLevel.fatal] and returns the given `message`.
/// If you want to avoid logging to a particular client that was
/// previously registered, use `exceptFor` to filter out that client.
String logFatal(
  String message, {
  Map<String, String>? extras,
  List<Type> exceptFor = const [],
}) {
  _filterOutClientsAndLog(exceptFor, (c) => c.logFatal(message, extras), LogLevel.fatal);
  return message;
}

/// It calls the `logError` method of each [LumberdashClient] of 
/// [LogLevel.error] and returns the given `exception`.
/// If you want to avoid logging to a particular client that was
/// previously registered, use `exceptFor` to filter out that client.
dynamic logError(
  dynamic exception, {
  dynamic stacktrace,
  List<Type> exceptFor = const [],
}) {
  _filterOutClientsAndLog(exceptFor, (c) => c.logError(exception, stacktrace), LogLevel.error);
  return exception;
}

typedef Logger = Function(LumberdashClient client);

void _filterOutClientsAndLog(
  List<Type> clientsToFilterOut,
  Logger logger,
  LogLevel logLevel
) {
  _lumberdashClients[logLevel]
      ?.where((client) => !clientsToFilterOut.contains(client.runtimeType))
      .forEach((c) => logger(c));
}
