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

extension IterableExtension<E> on Iterable<E> {
  List<T> mapToList<T>(T Function(E e) toElement) => map(toElement).toList();
}
