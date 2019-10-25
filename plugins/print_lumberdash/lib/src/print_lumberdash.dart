import 'package:lumberdash/lumberdash.dart';

/// [LumberdashClient] that prints your logs using `print()`
class PrintLumberdash extends LumberdashClient {
  /// Prints a regular message
  @override
  void logMessage(String message, [Map<String, String> extras]) {
    _log('MESSAGE', message, extras);
  }

  /// Prints a warning message
  @override
  void logWarning(String message, [Map<String, String> extras]) {
    _log('WARNING', message, extras);
  }

  /// Prints a fatal message
  @override
  void logFatal(String message, [Map<String, String> extras]) {
    _log('FATAL', message, extras);
  }

  /// Prints an error message
  @override
  void logError(exception, [dynamic stacktrace]) {
    print('[ERROR] { exception: $exception, stacktrace: $stacktrace }');
  }

  void _log(String tag, String message, Map<String, dynamic> extras) {
    if (extras != null) {
      print('[$tag] $message, extras: $extras');
    } else {
      print('[$tag] $message');
    }
  }
}
