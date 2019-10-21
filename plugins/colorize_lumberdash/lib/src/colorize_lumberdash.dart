import 'package:ansicolor/ansicolor.dart';
import 'package:lumberdash/lumberdash.dart';

/// [LumberdashClient] that colors your logs in the stdout depending
/// on their severity level
class ColorizeLumberdash extends LumberdashClient {
  /// Prints a regular message to stdout without any color treatment
  @override
  void logMessage(String message, [Map<String, dynamic> extras]) {
    print(_format('MESSAGE', message, extras));
  }

  /// Prints the given message in a yellow background with a black
  /// font
  @override
  void logWarning(String message, [Map<String, dynamic> extras]) {
    final warning = AnsiPen()
      ..black()
      ..yellow(bg: true);
    print(warning(_format('WARNING', message, extras)));
  }

  /// Prints the given message in light red background with a white
  /// font
  @override
  void logFatal(String message, [Map<String, dynamic> extras]) {
    final fatal = AnsiPen()
      ..white()
      ..red(bg: true);
    print(fatal(_format('FATAL', message, extras)));
  }

  /// Printst the given message in a red background with a white
  /// font
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    final error = AnsiPen()
      ..white(bold: true)
      ..xterm(88, bg: true);
    print(error('[ERROR] { exception: $exception, stacktrace: $stacktrace }'));
  }

  String _format(String tag, String message, Map<String, dynamic> extras) {
    if (extras != null) {
      return '[$tag] $message, extras: $extras';
    } else {
      return '[$tag] $message';
    }
  }
}
