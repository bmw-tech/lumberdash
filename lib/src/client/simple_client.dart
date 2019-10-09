import 'lumberdash_client.dart';

/// [SimpleClient] is the simplest version of a [LumberdashClient] you
/// can find. It prints all the logs to the terminal using a simple
/// `print` call.
class SimpleClient extends LumberdashClient {
  /// It prints the `message` and the `extras` on stdout using `print`
  @override
  void logMessage(String message, [Map<String, dynamic> extras, String eventName]) {
    print('Message { message: $message, extras: $extras, eventName: $eventName }');
  }

  /// It prints the `message` and the `extras` on stdout using `print`
  @override
  void logWarning(String message, [Map<String, dynamic> extras, String eventName]) {
    print('Warning { message: $message, extras: $extras, eventName: $eventName }');
  }

  /// It prints the `message` and the `extras` on stdout using `print`
  @override
  void logFatal(String message, [Map<String, dynamic> extras, String eventName]) {
    print('Fatal { message: $message, extras: $extras, eventName: $eventName }');
  }

  /// It prints the `exception` and the `stactrace` on stdout using
  /// `print`
  @override
  void logError(exception, [stacktrace, String eventName]) {
    print('Error { exception: $exception, stacktrace: $stacktrace, eventName: $eventName }');
  }
}
