/// [LumberdashClient] defines the API for producing logs.
abstract class LumberdashClient {
  /// Use `logMessage` to produce an mere informative log.
  /// `message` is the most important piece of the log, and `extras`
  /// are attached information that can be added to expand the meaning
  /// and context of your log.
  void logMessage(String message, [Map<String, dynamic> extras]);

  /// Use `logWarning` to produce a log that requires a special level
  /// of attention, since it might indicate an unexpected situation,
  /// or something that should not happen
  /// `message` is the most important piece of the log, and `extras`
  /// are attached information that can be added to expand the meaning
  /// and context of your log.
  void logWarning(String message, [Map<String, dynamic> extras]);

  /// Use `logFatal` to produce a log that represents an irreparable
  /// situation. This level of logs should require your total
  /// attention. In an ideal world, you should never see this type
  /// of logs.
  /// `message` is the most important piece of the log, and `extras`
  /// are attached information that can be added to expand the meaning
  /// and context of your log.
  void logFatal(String message, [Map<String, dynamic> extras]);

  /// Use `logError`, in a similar fashion to `logFatal`, should be
  /// used to capture a situation that cannot be fixed and requires a
  /// special level of attention. However, in this case you can use
  /// this method to capture an `exception` and a `stacktrace`, in
  /// case your irreparable situation represents a crash in your code.
  void logError(dynamic exception, [dynamic stacktrace]);
}
