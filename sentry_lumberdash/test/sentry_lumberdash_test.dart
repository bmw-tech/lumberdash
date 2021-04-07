import 'package:lumberdash/lumberdash.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../lib/sentry_lumberdash.dart';
import 'package:sentry/sentry.dart';

void main() {
  group('sentry_lumberdash', () {
    late MockHub mockHub;

    setUp(() {
      mockHub = MockHub();
      putLumberdashToWork(withClients: [SentryLumberdash(hub: mockHub)]);
    });

    test('create instance', () {
      try {
        final sentryLumberdash = SentryLumberdash();
        expect(
          sentryLumberdash,
          isA<SentryLumberdash>(),
        );
      } catch (e) {
        fail('Exception occured when creating a sentryLumberdash: $e');
      }
    });

    test('logMessage', () {
      logMessage('foo');
      expect(mockHub.addBreadcrumbCalls.length, 1);
      expect(mockHub.addBreadcrumbCalls.first.crumb.message, 'foo');
      expect(mockHub.addBreadcrumbCalls.first.crumb.level, SentryLevel.info);
      expect(mockHub.addBreadcrumbCalls.first.crumb.data, null);
    });

    test('logMessage with extras', () {
      logMessage('foo', extras: {'foo': 'bar'});
      expect(mockHub.addBreadcrumbCalls.length, 1);
      expect(mockHub.addBreadcrumbCalls.first.crumb.message, 'foo');
      expect(mockHub.addBreadcrumbCalls.first.crumb.level, SentryLevel.info);
      expect(mockHub.addBreadcrumbCalls.first.crumb.data, {'foo': 'bar'});
    });

    test('logWarning', () {
      logWarning('foo');
      expect(mockHub.addBreadcrumbCalls.length, 1);
      expect(mockHub.addBreadcrumbCalls.first.crumb.message, 'foo');
      expect(mockHub.addBreadcrumbCalls.first.crumb.level, SentryLevel.warning);
      expect(mockHub.addBreadcrumbCalls.first.crumb.data, null);
    });

    test('logWarning with extras', () {
      logWarning('foo', extras: {'foo': 'bar'});
      expect(mockHub.addBreadcrumbCalls.length, 1);
      expect(mockHub.addBreadcrumbCalls.first.crumb.message, 'foo');
      expect(mockHub.addBreadcrumbCalls.first.crumb.level, SentryLevel.warning);
      expect(mockHub.addBreadcrumbCalls.first.crumb.data, {'foo': 'bar'});
    });

    test('logFatal', () {
      logFatal('foo');
      expect(mockHub.addBreadcrumbCalls.length, 1);
      expect(mockHub.addBreadcrumbCalls.first.crumb.message, 'foo');
      expect(mockHub.addBreadcrumbCalls.first.crumb.level, SentryLevel.fatal);
      expect(mockHub.addBreadcrumbCalls.first.crumb.data, null);
    });

    test('logFatal with extras', () {
      logFatal('foo', extras: {'foo': 'bar'});
      expect(mockHub.addBreadcrumbCalls.length, 1);
      expect(mockHub.addBreadcrumbCalls.first.crumb.message, 'foo');
      expect(mockHub.addBreadcrumbCalls.first.crumb.level, SentryLevel.fatal);
      expect(mockHub.addBreadcrumbCalls.first.crumb.data, {'foo': 'bar'});
    });

    test('logError', () {
      logError('foo');
      expect(mockHub.captureExceptionCalls.length, 1);
      expect(mockHub.captureExceptionCalls.first.throwable, 'foo');
      expect(mockHub.captureExceptionCalls.first.stackTrace, null);
    });

    test('logFatal with stacktrace', () {
      logError('foo', stacktrace: 'bar');
      expect(mockHub.captureExceptionCalls.length, 1);
      expect(mockHub.captureExceptionCalls.first.throwable, 'foo');
      expect(mockHub.captureExceptionCalls.first.stackTrace, 'bar');
    });
  });
}

class MockHub implements Hub {
  List<CaptureExceptionCall> captureExceptionCalls = [];
  List<AddBreadcrumbCall> addBreadcrumbCalls = [];
  List<SentryClient?> bindClientCalls = [];
  int closeCalls = 0;

  @override
  void addBreadcrumb(Breadcrumb crumb, {dynamic hint}) {
    addBreadcrumbCalls.add(AddBreadcrumbCall(crumb, hint));
  }

  @override
  Future<SentryId> captureException(
    dynamic throwable, {
    dynamic stackTrace,
    dynamic hint,
  }) async {
    captureExceptionCalls
        .add(CaptureExceptionCall(throwable, stackTrace, hint));
    return SentryId.newId();
  }

  // The following methods and properties are not needed for the tests.

  @override
  void bindClient(SentryClient client) {
    throw UnimplementedError();
  }

  @override
  Future<SentryId> captureEvent(
    SentryEvent event, {
    dynamic stackTrace,
    dynamic hint,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<SentryId> captureMessage(
    String? message, {
    SentryLevel? level = SentryLevel.info,
    String? template,
    List? params,
    dynamic hint,
  }) async {
    throw UnimplementedError();
  }

  @override
  Hub clone() {
    throw UnimplementedError();
  }

  @override
  Future<void> close() async {}

  @override
  void configureScope(callback) {}

  @override
  bool get isEnabled => throw UnimplementedError();

  @override
  SentryId get lastEventId => throw UnimplementedError();
}

class CaptureExceptionCall {
  final dynamic throwable;
  final dynamic stackTrace;
  final dynamic hint;

  CaptureExceptionCall(
    this.throwable,
    this.stackTrace,
    this.hint,
  );
}

class AddBreadcrumbCall {
  final Breadcrumb crumb;
  final dynamic hint;

  AddBreadcrumbCall(this.crumb, this.hint);
}
