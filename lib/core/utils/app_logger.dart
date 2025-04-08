import 'package:logger/logger.dart';

class AppLogger {
  final Logger _logger;

  AppLogger({Logger? logger})
      : _logger = logger ?? Logger(printer: PrettyPrinter());

  void logInfo(String message) {
    _logger.i(message);
  }

  void logError(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
