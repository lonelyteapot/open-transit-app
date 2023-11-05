import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    lineLength: 80,
    printEmojis: true,
    methodCount: 0,
    noBoxingByDefault: true,
    levelColors: {
      Level.debug: const AnsiColor.fg(10),
      Level.info: const AnsiColor.fg(81),
    },
    levelEmojis: {
      Level.debug: '🪲',
      Level.info: '🔷',
      Level.warning: '🍊',
    },
  ),
);
