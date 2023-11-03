import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'layout_orientation.g.dart';

@Riverpod(keepAlive: true)
Orientation layoutOrientation(LayoutOrientationRef ref) {
  throw UnimplementedError('This provider must be overridden');
}
