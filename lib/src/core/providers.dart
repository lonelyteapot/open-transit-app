import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'providers.g.dart';

@riverpod
ScrollController primaryScrollController(PrimaryScrollControllerRef ref) {
  return ScrollController();
}

@riverpod
PanelController? slidingPanelController(SlidingPanelControllerRef ref) {
  return null;
}

@Riverpod(keepAlive: true)
GoRouterState goRouterState(GoRouterStateRef ref) {
  throw UnimplementedError();
}
