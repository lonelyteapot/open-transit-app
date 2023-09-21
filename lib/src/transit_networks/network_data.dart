import 'package:flutter/material.dart';

@immutable
class TransitNetwork {
  const TransitNetwork({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
}
