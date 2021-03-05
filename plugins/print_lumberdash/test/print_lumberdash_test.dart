import 'package:test/test.dart';

import '../lib/print_lumberdash.dart';

void main() {
  group('print_lumberdash', () {
    test('create instance', () {
      try {
        final printLumberdash = PrintLumberdash();
        expect(
          printLumberdash,
          isA<PrintLumberdash>(),
        );
      } catch (e) {
        fail('Exception occured when creating a PrintLumberdash: $e');
      }
    });
  });
}
