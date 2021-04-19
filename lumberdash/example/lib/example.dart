import 'package:lumberdash/lumberdash.dart';

void main() {
  putLumberdashToWork(withClients: []);
  logWarning('Hello Warning');
  logFatal('Hello Fatal!');
  logMessage('Hello Message!');
  logError(Exception('Hello Error'));
}
