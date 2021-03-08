import 'dart:io';

import 'package:lumberdash/lumberdash.dart';
import 'package:synchronized/synchronized.dart';

/// [LumberdashClient] that writes your logs to the given file path
/// in the file system
class FileLumberdash extends LumberdashClient {
  File _logFile;
  static final _lock = Lock();

  FileLumberdash({
    required String filePath,
  }) : _logFile = File(filePath);

  /// Records a regular message
  @override
  void logMessage(String message, [Map<String, String>? extras]) {
    if (extras != null) {
      _log('[MESSAGE] $message, extras: $extras');
    } else {
      _log('[MESSAGE] $message');
    }
  }

  /// Records a warning message
  @override
  void logWarning(String message, [Map<String, String>? extras]) {
    if (extras != null) {
      _log('[WARNING] $message, extras: $extras');
    } else {
      _log('[WARNING] $message');
    }
  }

  /// Records a fatal message
  @override
  void logFatal(String message, [Map<String, String>? extras]) {
    if (extras != null) {
      _log('[FATAL] $message, extras: $extras');
    } else {
      _log('[FATAL] $message');
    }
  }

  /// Records an error message
  @override
  Future<void> logError(exception, [dynamic stacktrace]) async {
    if (stacktrace != null) {
      _log('[ERROR] { exception: $exception, stacktrace: $stacktrace }');
    } else {
      _log('[ERROR] { exception: $exception }');
    }
  }

  Future<void> _log(String data) async {
    try {
      _lock.synchronized(() async {
        final date = DateTime.now();
        await _logFile.writeAsString(
          '${date.toIso8601String()}${date.timeZoneOffset} - $data\n',
          mode: FileMode.writeOnlyAppend,
          flush: true,
        );
      });
    } catch (e) {
      print("Lumberdash exception: $e");
    }
  }
}
