import 'package:test/test.dart';

import '../lib/file_lumberdash.dart';

void main() {
  group('file_lumberdash', () {
    test('create instance', () {
      try {
        final fileLumberdash = FileLumberdash(filePath: "testFolder/");
        expect(
          fileLumberdash,
          isA<FileLumberdash>(),
        );
      } catch (e) {
        fail('Exception occured when creating a FileLumberdash: $e');
      }
    });

    test('create instance with a null filePath should throw', () {
      try {
        FileLumberdash(filePath: null);
        fail('Should throw an exception');
      } catch (e) {
        expect(e is AssertionError, isTrue);
      }
    });
  });
}
