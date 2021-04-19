import 'package:lumberdash/lumberdash.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_lumberdash/sentry_lumberdash.dart';

void main() {
  Sentry.init(
    (options) {
      options.dsn = 'https://example@sentry.io/add-your-dsn-here';
    },
  );
  putLumberdashToWork(
    withClients: [SentryLumberdash()],
  );
  logWarning('Hello Warning');
  logFatal('Hello Fatal!');
  logMessage('Hello Message!');
  logError(Exception('Hello Error'));
}
