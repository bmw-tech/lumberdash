import 'package:lumberdash/lumberdash.dart';

void main() {
  putLumberdashToWork(withClient: SimpleClient());
  logWarning('Hello Warning');
  logFatal('Hello Fatal!');
  logMessage('Hello Message!');
  logError(Exception('Hello Error'));
}
