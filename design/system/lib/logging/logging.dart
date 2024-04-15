import 'dart:convert';

import 'package:design/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as log;
import 'package:logger/logger.dart';

class _Filter extends LogFilter {
  @override
  Future<void> init() async => level = kDebugMode ? log.Level.trace : log.Level.error;

  @override
  bool shouldLog(log.LogEvent event) => event.level.index >= level!.index;
}

class Logging {
  static final log.Logger logger = log.Logger(
    level: kDebugMode ? log.Level.trace : log.Level.error,
    output: ConsoleOutput(),
    filter: _Filter(),
  );

  Logging._();

  static void info(dynamic message) {
    try {
      logger.i(const JsonEncoder.withIndent("  ").convert(message));
    } catch (_) {
      logger.i(message.toString());
    }
  }

  static void error(error, [stack, String message = empty]) => logger.e(error.toString() + newLine + message, error: error, stackTrace: stack);
}
