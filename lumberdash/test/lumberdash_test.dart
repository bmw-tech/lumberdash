import 'package:lumberdash/lumberdash.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements LumberdashClient {}

class FilterOutClient extends Mock implements LumberdashClient {}

void main() {
  group('putLumberdashToWork', () {
    test('should use the given client for logging', () {
      final mockClient = MockClient();

      putLumberdashToWork(withClients: [mockClient]);
      logMessage('Message');
      logWarning('Warning');
      logFatal('Fatal');
      logError('Error');

      verify(mockClient.logMessage('Message')).called(1);
      verify(mockClient.logWarning('Warning')).called(1);
      verify(mockClient.logFatal('Fatal')).called(1);
      verify(mockClient.logError('Error')).called(1);
    });
  });

  group('log API', () {
    test('logMessage returns the given message', () {
      final mockClient1 = MockClient();
      final mockClient2 = MockClient();

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logMessage('Message');

      expect(result, 'Message');
      verify(mockClient1.logMessage('Message'));
      verify(mockClient2.logMessage('Message'));
    });

    test('logMessage filters out exceptFor clients', () {
      final mockClient1 = MockClient();
      final mockClient2 = FilterOutClient();

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logMessage('Message', exceptFor: [FilterOutClient]);

      expect(result, 'Message');
      verify(mockClient1.logMessage('Message'));
      verifyZeroInteractions(mockClient2);
    });

    test('logWarning returns the given message', () {
      final mockClient1 = MockClient();
      final mockClient2 = MockClient();

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logWarning('Warning');

      expect(result, 'Warning');
      verify(mockClient1.logWarning('Warning'));
      verify(mockClient2.logWarning('Warning'));
    });

    test('logWarning filters out exceptFor clients', () {
      final mockClient1 = MockClient();
      final mockClient2 = FilterOutClient();

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logWarning('Warning', exceptFor: [FilterOutClient]);

      expect(result, 'Warning');
      verify(mockClient1.logWarning('Warning'));
      verifyZeroInteractions(mockClient2);
    });

    test('logFatal returns the given message', () {
      final mockClient1 = MockClient();
      final mockClient2 = MockClient();

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logFatal('Fatal');

      expect(result, 'Fatal');
      verify(mockClient1.logFatal('Fatal'));
      verify(mockClient2.logFatal('Fatal'));
    });

    test('logFatal filters out exceptFor clients', () {
      final mockClient1 = MockClient();
      final mockClient2 = FilterOutClient();

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logFatal('Fatal', exceptFor: [FilterOutClient]);

      expect(result, 'Fatal');
      verify(mockClient1.logFatal('Fatal'));
      verifyZeroInteractions(mockClient2);
    });

    test('logError returns the given exception', () {
      final mockClient1 = MockClient();
      final mockClient2 = MockClient();

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final exception = Exception('Error');
      final result = logError(exception);

      expect(result, exception);
      verify(mockClient1.logError(any));
      verify(mockClient2.logError(any));
    });

    test('logError filters out exceptFor clients', () {
      final mockClient1 = MockClient();
      final mockClient2 = FilterOutClient();

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logError('Error', exceptFor: [FilterOutClient]);

      expect(result, 'Error');
      verify(mockClient1.logError('Error'));
      verifyZeroInteractions(mockClient2);
    });
  });

  group('LogLevel handling', () {
    test('should use the the given client with LogLevel error', () {
      final mockClient = MockClient();

      putLumberdashToWorkByLogLevel(withClients: {
        mockClient: [LogLevel.fatal]
      });
      logMessage('Message');
      logWarning('Warning');
      logFatal('Fatal');
      logError('Error');

      verifyNever(mockClient.logMessage('Error'));
      verifyNever(mockClient.logWarning('Error'));
      verify(mockClient.logFatal('Fatal')).called(1);
      verifyNever(mockClient.logError('Error'));
    });

    test(
        'should use the the given client with LogLevel message, warning, error',
        () {
      final mockClient = MockClient();

      putLumberdashToWorkByLogLevel(withClients: {
        mockClient: [LogLevel.message, LogLevel.warning, LogLevel.error]
      });
      logMessage('Message');
      logWarning('Warning');
      logFatal('Fatal');
      logError('Error');

      verify(mockClient.logMessage('Message')).called(1);
      verify(mockClient.logWarning('Warning')).called(1);
      verifyNever(mockClient.logFatal('Fatal'));
      verify(mockClient.logError('Error')).called(1);
    });

    test('use LogLevel set for each client', () {
      final mockClient1 = MockClient();
      final mockClient2 = MockClient();

      putLumberdashToWorkByLogLevel(withClients: {
        mockClient1: [LogLevel.warning, LogLevel.error],
        mockClient2: [LogLevel.message, LogLevel.fatal]
      });
      logMessage('Message');
      logWarning('Warning');
      logFatal('Fatal');
      logError('Error');

      verifyNever(mockClient1.logMessage('Message'));
      verify(mockClient1.logWarning('Warning')).called(1);
      verifyNever(mockClient1.logFatal('Fatal'));
      verify(mockClient1.logError('Error')).called(1);
      verify(mockClient2.logMessage('Message')).called(1);
      verifyNever(mockClient2.logWarning('Warning'));
      verify(mockClient2.logFatal('Fatal')).called(1);
      verifyNever(mockClient2.logError('Error'));
    });

    test('use all LogLevels', () {
      final mockClient = MockClient();

      putLumberdashToWork(withClients: [mockClient]);
      logMessage('Message');
      logWarning('Warning');
      logFatal('Fatal');
      logError('Error');

      verify(mockClient.logMessage('Message')).called(1);
      verify(mockClient.logWarning('Warning')).called(1);
      verify(mockClient.logFatal('Fatal')).called(1);
      verify(mockClient.logError('Error')).called(1);
    });

    test('filter client of a specific LogLevel', () {
      final mockClient = FilterOutClient();

      putLumberdashToWorkByLogLevel(withClients: {
        mockClient: [LogLevel.message]
      });
      logMessage('Message', exceptFor: [FilterOutClient]);
      logWarning('Warning');
      logFatal('Fatal');
      logError('Error');

      verifyZeroInteractions(mockClient);
    });
  });
}
