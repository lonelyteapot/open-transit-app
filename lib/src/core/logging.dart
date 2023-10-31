import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    lineLength: 64,
    printEmojis: false,
    methodCount: 1,
  ),
);
