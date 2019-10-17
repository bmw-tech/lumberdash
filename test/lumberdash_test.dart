import 'package:lumberdash/lumberdash.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements LumberdashClient {}

void main() {
  group('putLumberdashToWork', () {
    test('should break if no client is given', () {
      try {
        putLumberdashToWork(withClients: null);
        fail('This could should not work');
      } catch (e) {
        expect(e is AssertionError, isTrue);
      }
    });

    test('should use the given client for logging', () {
      final mockClient = MockClient();
      when(mockClient.logMessage(any)).thenReturn(null);
      when(mockClient.logWarning(any)).thenReturn(null);
      when(mockClient.logFatal(any)).thenReturn(null);
      when(mockClient.logError(any)).thenReturn(null);

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
      when(mockClient1.logMessage(any)).thenReturn(null);
      when(mockClient2.logMessage(any)).thenReturn(null);

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logMessage('Message');

      expect(result, 'Message');
      verify(mockClient1.logMessage('Message'));
      verify(mockClient2.logMessage('Message'));
    });

    test('logWarning returns the given message', () {
      final mockClient1 = MockClient();
      final mockClient2 = MockClient();
      when(mockClient1.logWarning(any)).thenReturn(null);
      when(mockClient2.logWarning(any)).thenReturn(null);

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logWarning('Warning');

      expect(result, 'Warning');
      verify(mockClient1.logWarning('Warning'));
      verify(mockClient2.logWarning('Warning'));
    });

    test('logFatal returns the given message', () {
      final mockClient1 = MockClient();
      final mockClient2 = MockClient();
      when(mockClient1.logFatal(any)).thenReturn(null);
      when(mockClient2.logFatal(any)).thenReturn(null);

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final result = logFatal('Fatal');

      expect(result, 'Fatal');
      verify(mockClient1.logFatal('Fatal'));
      verify(mockClient2.logFatal('Fatal'));
    });

    test('logError returns the given exception', () {
      final mockClient1 = MockClient();
      final mockClient2 = MockClient();
      when(mockClient1.logError(any)).thenReturn(null);
      when(mockClient2.logError(any)).thenReturn(null);

      putLumberdashToWork(withClients: [mockClient1, mockClient2]);
      final exception = Exception('Error');
      final result = logError(exception);

      expect(result, exception);
      verify(mockClient1.logError(Exception('Error')));
      verify(mockClient2.logError(Exception('Error')));
    });
  });
}
