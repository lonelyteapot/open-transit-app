import 'package:flutter/material.dart';
import 'package:open_transit_app/utils.dart';

class RoutesView extends StatelessWidget {
  const RoutesView({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollControllerProvider.maybeUnwrap(
      context: context,
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.route),
            title: Text('Route ${index + 1}'),
          );
        },
      ),
    );
  }
}
