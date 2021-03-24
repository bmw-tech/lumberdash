import 'package:test/test.dart';

import '../lib/colorize_lumberdash.dart';

void main() {
  group('colorize_lumberdash', () {
    test('create instance', () {
      try {
        final colorizedLumberdash = ColorizeLumberdash();
        expect(
          colorizedLumberdash,
          isA<ColorizeLumberdash>(),
        );
      } catch (e) {
        fail('Exception occured when creating a ColorizedLumberdash: $e');
      }
    });
  });
}
