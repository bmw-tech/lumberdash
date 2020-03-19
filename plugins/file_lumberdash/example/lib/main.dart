import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_lumberdash/file_lumberdash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  final currentDate = DateTime.now();
  final fileName = '${currentDate.year}-${currentDate.month}-${currentDate.day}-logs';
  putLumberdashToWork(withClients: [
    FileLumberdash(
        filePath:
            '$appDocPath/$fileName.txt'),
  ]);
  logWarning('Hello Warning');
  logWarning('Hello Warning');
  logFatal('Hello Fatal!');
  logMessage('Hello Message!');
  logError(Exception('Hello Error'));
}
