import 'package:io/ansi.dart';
import 'package:lumberdash/lumberdash.dart';

/// [LumberdashClient] that colors your logs in the stdout depending
/// on their severity level
class ColorizeLumberdash extends LumberdashClient {
  /// Prints a regular message to stdout without any color treatment
  @override
  void logMessage(String message, [Map<String, dynamic> extras, String eventName]) {
    print('Message { message: $message, extras: $extras, eventName: $eventName }'); // no color added
  }

  /// Prints the given message in yellow
  @override
  void logWarning(String message, [Map<String, dynamic> extras, String eventName]) {
    final warning =
        yellow.wrap('Warning { message: $message, extras: $extras, eventName: $eventName }');
    print(warning);
  }

  /// Prints the given message in red
  @override
  void logFatal(String message, [Map<String, dynamic> extras, String eventName]) {
    final fatal = red.wrap('Fatal { message: $message, extras: $extras, eventName: $eventName }');
    print(fatal);
  }

  /// Printst the given message in a red background with white
  /// characters
  @override
  void logError(dynamic exception, [dynamic stacktrace, String eventName]) {
    final error =
        white.wrap('Error { exception: $exception, stacktrace: $stacktrace, eventName: $eventName }');
    final errorBg = backgroundRed.wrap(error);
    print(errorBg);
  }
}
