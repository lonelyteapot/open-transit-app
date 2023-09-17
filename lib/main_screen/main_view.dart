import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_transit_app/src/transit_networks/networks.dart';
import 'package:open_transit_app/src/transit_networks/selected_network.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: FilledButtonTheme(
        data: FilledButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        child: Builder(
          builder: (context) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopButtons(),
                SizedBox(height: 8),
                NetworkSelector(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TopButtons extends ConsumerWidget {
  const TopButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNetworkSelected =
        ref.watch(selectedNetworkProvider).valueOrNull != null;
    return GridView.count(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.5,
      clipBehavior: Clip.none,
      children: [
        FilledButton.tonal(
          onPressed: !isNetworkSelected
              ? null
              : () {
                  context.go('/routes');
                },
          style: FilledButtonTheme.of(context).style!.copyWith(
                shape: _createRoundedCornerShape(base: 8, topLeft: 16),
              ),
          child: const Text('Routes'),
        ),
        FilledButton.tonal(
          onPressed: !isNetworkSelected ? null : () {},
          child: const Text('Stops'),
        ),
        FilledButton.tonal(
          onPressed: !isNetworkSelected ? null : () {},
          style: FilledButtonTheme.of(context).style!.copyWith(
                shape: _createRoundedCornerShape(base: 8, topRight: 16),
              ),
          child: const Text('Stub'),
        ),
      ],
    );
  }
}

class NetworkSelector extends ConsumerWidget {
  const NetworkSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNetworks = ref.watch(transitNetworksProvider);
    final asyncSelectedNetwork = ref.watch(selectedNetworkProvider);
    final deselectingEntry = DropdownMenuEntry<TransitNetwork?>(
      value: null,
      label: '',
      leadingIcon: Text(
        'None',
        style: TextStyle(color: Theme.of(context).disabledColor),
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<TransitNetwork?>(
          enabled: asyncNetworks.hasValue,
          label: const Text('Location'),
          leadingIcon: const Icon(Icons.location_city),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            border: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          width: constraints.maxWidth,
          menuHeight: 615,
          initialSelection: asyncSelectedNetwork.valueOrNull,
          onSelected: (value) {
            ref.read(selectedNetworkProvider.notifier).select(value);
          },
          dropdownMenuEntries: asyncNetworks.maybeWhen(
            data: (data) => [deselectingEntry].followedBy(
              data.map((network) {
                return DropdownMenuEntry<TransitNetwork>(
                  value: network,
                  label: network.name,
                );
              }),
            ).toList(),
            orElse: List.empty,
          ),
        );
      },
    );
  }
}

MaterialStateProperty<OutlinedBorder?> _createRoundedCornerShape({
  required double base,
  double? topLeft,
  double? topRight,
  double? bottomLeft,
  double? bottomRight,
}) {
  return MaterialStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(base)).copyWith(
        topLeft: topLeft != null ? Radius.circular(topLeft) : null,
        topRight: topRight != null ? Radius.circular(topRight) : null,
        bottomLeft: bottomLeft != null ? Radius.circular(bottomLeft) : null,
        bottomRight: bottomRight != null ? Radius.circular(bottomRight) : null,
      ),
    ),
  );
}
