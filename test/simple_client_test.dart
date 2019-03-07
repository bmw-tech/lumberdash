import 'dart:async';

import 'package:lumberdash/lumberdash.dart';
import 'package:test/test.dart';

List<String> printLog;

void main() {
  group('logMessage', () {
    setUp(() {
      printLog = [];
    });

    test('prints correct message', overridePrint(() {
      final expectedMessage = 'Message { message: message, extras: null }';
      SimpleClient().logMessage('message');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with extras', overridePrint(() {
      final expectedMessage =
          'Message { message: message, extras: {hello: world} }';
      SimpleClient().logMessage('message', {'hello': 'world'});
      expect(printLog, [expectedMessage]);
    }));
  });

  group('logWarning', () {
    setUp(() {
      printLog = [];
    });
    test('prints correct message', overridePrint(() {
      final expectedMessage = 'Warning { message: message, extras: null }';
      SimpleClient().logWarning('message');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with extras', overridePrint(() {
      final expectedMessage =
          'Warning { message: message, extras: {hello: world} }';
      SimpleClient().logWarning('message', {'hello': 'world'});
      expect(printLog, [expectedMessage]);
    }));
  });

  group('logFatal', () {
    setUp(() {
      printLog = [];
    });
    test('prints correct message', overridePrint(() {
      final expectedMessage = 'Fatal { message: message, extras: null }';
      SimpleClient().logFatal('message');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with extras', overridePrint(() {
      final expectedMessage =
          'Fatal { message: message, extras: {hello: world} }';
      SimpleClient().logFatal('message', {'hello': 'world'});
      expect(printLog, [expectedMessage]);
    }));
  });

  group('logError', () {
    setUp(() {
      printLog = [];
    });
    test('prints correct exception', overridePrint(() {
      final String expectedMessage =
          'Error { exception: exception, stacktrace: null }';
      SimpleClient().logError('exception');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct exception with stacktrace', overridePrint(() {
      final String expectedMessage =
          'Error { exception: exception, stacktrace: stacktrace }';
      SimpleClient().logError('exception', 'stacktrace');
      expect(printLog, [expectedMessage]);
    }));
  });
}

overridePrint(testFn()) => () {
      ZoneSpecification spec =
          ZoneSpecification(print: (_, __, ___, String msg) {
        printLog.add(msg);
      });
      return Zone.current.fork(specification: spec).run(testFn);
    };
