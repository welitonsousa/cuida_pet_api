import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:logger/logger.dart' as LOG;

class Logger extends ILogger {
  final _logger = LOG.Logger();

  @override
  void debug(message, [error, StackTrace? stacktrace]) {
    _logger.d(message, error, stacktrace);
  }

  @override
  void error(message, [error, StackTrace? stacktrace]) {
    _logger.e(message, error, stacktrace);
  }

  @override
  void info(message, [error, StackTrace? stacktrace]) {
    _logger.i(message, error, stacktrace);
  }

  @override
  void warning(message, [error, StackTrace? stacktrace]) {
    _logger.w(message, error, stacktrace);
  }
}
