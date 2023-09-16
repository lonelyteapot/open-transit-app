import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  bool get isDark {
    return brightness == Brightness.dark;
  }
}

class PrimaryScrollControllerProvider extends InheritedWidget {
  const PrimaryScrollControllerProvider({
    super.key,
    required this.controller,
    required this.automaticallyInheritForPlatforms,
    this.scrollDirection = Axis.vertical,
    required super.child,
  });

  final ScrollController? controller;
  final Set<TargetPlatform> automaticallyInheritForPlatforms;
  final Axis? scrollDirection;

  static Widget maybeUnwrap({
    required BuildContext context,
    required Widget child,
  }) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<PrimaryScrollControllerProvider>();
    if (widget == null) {
      return child;
    }
    return PrimaryScrollController(
      controller: widget.controller!,
      automaticallyInheritForPlatforms: widget.automaticallyInheritForPlatforms,
      scrollDirection: widget.scrollDirection,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(PrimaryScrollControllerProvider oldWidget) =>
      controller != oldWidget.controller;
}
