import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class TransitNetwork {
  const TransitNetwork({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
}

class TransitNetworksNotifier extends AsyncNotifier<List<TransitNetwork>> {
  @override
  FutureOr<List<TransitNetwork>> build() {
    return [
      const TransitNetwork(
        id: 'tn1',
        name: 'Transit Network 1',
      ),
      const TransitNetwork(
        id: 'tn2',
        name: 'Transit Network 2',
      ),
      const TransitNetwork(
        id: 'tn3',
        name: 'Transit Network 3',
      ),
      const TransitNetwork(
        id: 'tn4',
        name: 'Transit Network 4',
      ),
    ];
  }
}

final transitNetworksProvider =
    AsyncNotifierProvider<TransitNetworksNotifier, List<TransitNetwork>>(
        TransitNetworksNotifier.new);