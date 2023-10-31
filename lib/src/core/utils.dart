import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

extension BuildContextExtension on BuildContext {
  void goRelative(
    String location, {
    Object? extra,
  }) {
    assert(
      !location.startsWith('/'),
      "Relative locations must not start with a '/'",
    );

    final state = GoRouterState.of(this);
    final newPath = '${state.uri.path}/$location';
    go(newPath, extra: extra);
  }
}
