import 'package:colorize/colorize.dart';
import 'package:lumberdash/lumberdash.dart';

class ColorizeLumberdash extends LumberdashClient {

  @override
  void logMessage(String message, [Map<String, dynamic> extras]) {
    print('Message { message: $message, extras: $extras }'); // no color added
  }

  @override
  void logWarning(String message, [Map<String, dynamic> extras]) {
    final warning = Colorize('Warning { message: $message, extras: $extras }');
    warning.yellow();
    print(warning);
  }

  @override
  void logFatal(String message, [Map<String, dynamic> extras]) {
    final fatal = Colorize('Fatal { message: $message, extras: $extras }');
    fatal.red();
    print(fatal);
  }

  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    final error = Colorize('Error { exception: $exception, stacktrace: $stacktrace }');
    error.bgRed();
    error.white();
    print(error);
  }
}