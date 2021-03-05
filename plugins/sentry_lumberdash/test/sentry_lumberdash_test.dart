import 'package:test/test.dart';

import '../lib/sentry_lumberdash.dart';

void main() {
  group('sentry_lumberdash', () {
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
  });
}
