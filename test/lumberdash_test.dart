import 'package:lumberdash/lumberdash.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements LumberdashClient {}

void main() {
  group('putLumberdashToWork', () {
    test('should break if no client is given', () {
      try {
        putLumberdashToWork(withClient: null);
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

      putLumberdashToWork(withClient: mockClient);
      logMessage('Message');
      logWarning('Warning');
      logFatal('Fatal');
      logError('Error');

      verify(mockClient.logMessage('Message')).called(1);
      verify(mockClient.logWarning('Warning')).called(1);
      verify(mockClient.logFatal('Fatal')).called(1);
      verify(mockClient.logError('Error')).called(1);
    });

    test(
        'lumberdashClient getter returns the instance pass to putLumberdashToWork',
        () {
      final mockClient = MockClient();
      putLumberdashToWork(withClient: mockClient);
      expect(lumberdashClient, mockClient);
    });
  });

  group('log API', () {
    test('logMessage returns the given message', () {
      final mockClient = MockClient();
      when(mockClient.logMessage(any)).thenReturn(null);

      putLumberdashToWork(withClient: mockClient);
      final result = logMessage('Message');

      expect(result, 'Message');
    });

    test('logWarning returns the given message', () {
      final mockClient = MockClient();
      when(mockClient.logWarning(any)).thenReturn(null);

      putLumberdashToWork(withClient: mockClient);
      final result = logWarning('Warning');

      expect(result, 'Warning');
    });

    test('logFatal returns the given message', () {
      final mockClient = MockClient();
      when(mockClient.logFatal(any)).thenReturn(null);

      putLumberdashToWork(withClient: mockClient);
      final result = logFatal('Fatal');

      expect(result, 'Fatal');
    });

    test('logError returns the given exception', () {
      final mockClient = MockClient();
      when(mockClient.logError(any)).thenReturn(null);

      putLumberdashToWork(withClient: mockClient);
      final exception = Exception('Error');
      final result = logError(exception);

      expect(result, exception);
    });
  });
}
