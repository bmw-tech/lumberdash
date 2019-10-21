import 'package:ansicolor/ansicolor.dart';
import 'package:lumberdash/lumberdash.dart';

/// [LumberdashClient] that colors your logs in the stdout depending
/// on their severity level
class ColorizeLumberdash extends LumberdashClient {
  /// Prints a regular message to stdout without any color treatment
  @override
  void logMessage(String message, [Map<String, dynamic> extras]) {
    print('Message { message: $message, extras: $extras }'); // no color added
  }

  /// Prints the given message in a yellow background with a black
  /// font
  @override
  void logWarning(String message, [Map<String, dynamic> extras]) {
    final warning = AnsiPen()
      ..black()
      ..yellow(bg: true);
    print(warning(('Warning { message: $message, extras: $extras }')));
  }

  /// Prints the given message in light red background with a white
  /// font
  @override
  void logFatal(String message, [Map<String, dynamic> extras]) {
    final fatal = AnsiPen()
      ..white()
      ..red(bg: true);
    print(fatal('Fatal { message: $message, extras: $extras }'));
  }

  /// Printst the given message in a red background with a white
  /// font
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    final error = AnsiPen()
      ..white(bold: true)
      ..xterm(88, bg: true);
    print(error('Error { exception: $exception, stacktrace: $stacktrace }'));
  }
}
