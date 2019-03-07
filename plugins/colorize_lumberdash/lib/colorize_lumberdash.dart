import 'package:colorize/colorize.dart';
import 'package:lumberdash/lumberdash.dart';

/// [LumberdashClient] that colors your logs in the stdout depending
/// on their severity level
class ColorizeLumberdash extends LumberdashClient {

  /// Prints a regular message to stdout without any color treatment
  @override
  void logMessage(String message, [Map<String, dynamic> extras]) {
    print('Message { message: $message, extras: $extras }'); // no color added
  }

  /// Prints the given message in yellow
  @override
  void logWarning(String message, [Map<String, dynamic> extras]) {
    final warning = Colorize('Warning { message: $message, extras: $extras }');
    warning.yellow();
    print(warning);
  }

  /// Prints the given message in red
  @override
  void logFatal(String message, [Map<String, dynamic> extras]) {
    final fatal = Colorize('Fatal { message: $message, extras: $extras }');
    fatal.red();
    print(fatal);
  }

  /// Printst the given message in a red background with white 
  /// characters
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    final error = Colorize('Error { exception: $exception, stacktrace: $stacktrace }');
    error.bgRed();
    error.white();
    print(error);
  }
}