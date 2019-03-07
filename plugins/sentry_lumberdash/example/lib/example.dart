import 'package:lumberdash/lumberdash.dart';
import 'package:sentry_lumberdash/sentry_lumberdash.dart';

void main() {
  putLumberdashToWork(
    withClient: SentryLumberdash.withDsn(dsnKey: 'your_key'),
  );
  logWarning('Hello Warning');
  logFatal('Hello Fatal!');
  logMessage('Hello Message!');
  logError(Exception('Hello Error'));
}
