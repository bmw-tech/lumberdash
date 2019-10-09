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
      final expectedMessage =
          'Message { message: message, extras: null, eventName: null }';
      SimpleClient().logMessage('message');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with extras', overridePrint(() {
      final expectedMessage =
          'Message { message: message, extras: {hello: world}, eventName: null }';
      SimpleClient().logMessage('message', {'hello': 'world'});
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with eventName', overridePrint(() {
      final expectedMessage =
          'Message { message: message, extras: null, eventName: TestEvent }';
      SimpleClient().logMessage('message', null, 'TestEvent');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with eventName and extras', overridePrint(() {
      final expectedMessage =
          'Message { message: message, extras: {hello: world}, eventName: TestEvent }';
      SimpleClient().logMessage('message', {'hello': 'world'}, 'TestEvent');
      expect(printLog, [expectedMessage]);
    }));
  });

  group('logWarning', () {
    setUp(() {
      printLog = [];
    });
    test('prints correct message', overridePrint(() {
      final expectedMessage =
          'Warning { message: message, extras: null, eventName: null }';
      SimpleClient().logWarning('message');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with extras', overridePrint(() {
      final expectedMessage =
          'Warning { message: message, extras: {hello: world}, eventName: null }';
      SimpleClient().logWarning('message', {'hello': 'world'});
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with eventName', overridePrint(() {
      final expectedMessage =
          'Warning { message: message, extras: null, eventName: TestEvent }';
      SimpleClient().logWarning('message', null, 'TestEvent');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with eventName and extras', overridePrint(() {
      final expectedMessage =
          'Warning { message: message, extras: {hello: world}, eventName: TestEvent }';
      SimpleClient().logWarning('message', {'hello': 'world'}, 'TestEvent');
      expect(printLog, [expectedMessage]);
    }));
  });

  group('logFatal', () {
    setUp(() {
      printLog = [];
    });
    test('prints correct message', overridePrint(() {
      final expectedMessage =
          'Fatal { message: message, extras: null, eventName: null }';
      SimpleClient().logFatal('message');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with extras', overridePrint(() {
      final expectedMessage =
          'Fatal { message: message, extras: {hello: world}, eventName: null }';
      SimpleClient().logFatal('message', {'hello': 'world'});
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with eventName', overridePrint(() {
      final expectedMessage =
          'Fatal { message: message, extras: null, eventName: TestEvent }';
      SimpleClient().logFatal('message', null, 'TestEvent');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct message with eventName and extras', overridePrint(() {
      final expectedMessage =
          'Fatal { message: message, extras: {hello: world}, eventName: TestEvent }';
      SimpleClient().logFatal('message', {'hello': 'world'}, 'TestEvent');
      expect(printLog, [expectedMessage]);
    }));
  });

  group('logError', () {
    setUp(() {
      printLog = [];
    });
    test('prints correct exception', overridePrint(() {
      final String expectedMessage =
          'Error { exception: exception, stacktrace: null, eventName: null }';
      SimpleClient().logError('exception');
      expect(printLog, [expectedMessage]);
    }));

    test('prints correct exception with stacktrace', overridePrint(() {
      final String expectedMessage =
          'Error { exception: exception, stacktrace: stacktrace, eventName: null }';
      SimpleClient().logError('exception', 'stacktrace');
      expect(printLog, [expectedMessage]);
    }));
    test('prints correct exception with eventName', overridePrint(() {
      final String expectedMessage =
          'Error { exception: exception, stacktrace: null, eventName: TestEvent }';
      SimpleClient().logError('exception', null, 'TestEvent');
      expect(printLog, [expectedMessage]);
    }));
    test('prints correct exception with eventName and stacktrace',
        overridePrint(() {
      final String expectedMessage =
          'Error { exception: exception, stacktrace: stacktrace, eventName: TestEvent }';
      SimpleClient().logError('exception', 'stacktrace', 'TestEvent');
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
