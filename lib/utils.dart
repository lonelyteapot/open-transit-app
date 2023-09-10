import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  bool get isDark {
    return brightness == Brightness.dark;
  }
}
