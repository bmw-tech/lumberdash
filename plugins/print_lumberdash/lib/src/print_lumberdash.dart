import 'package:lumberdash/lumberdash.dart';

/// [LumberdashClient] that prints your logs using `print()`
class PrintLumberdash extends LumberdashClient {
  /// Prints a regular message
  @override
  void logMessage(String message, [Map<String, dynamic> extras]) {
    print('Message { message: $message, extas: $extras }');
  }

  /// Prints a warning message
  @override
  void logWarning(String message, [Map<String, dynamic> extras]) {
    print('Warning { message: $message, extas: $extras }');
  }

  /// Prints a fatal message
  @override
  void logFatal(String message, [Map<String, dynamic> extras]) {
    print('Fatal { message: $message, extras: $extras }');
  }

  /// Prints an error message
  @override
  void logError(exception, [dynamic stacktrace]) {
    print('Error { exception: $exception, stacktrace: $stacktrace }');
  }
}
