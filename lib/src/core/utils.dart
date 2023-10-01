import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  bool get isDark {
    return brightness == Brightness.dark;
  }
}

extension StringExtension on String {
  String toCapitalized() {
    return isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  }
}
