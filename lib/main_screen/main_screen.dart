import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/main_screen/map_widget.dart';
import 'package:open_transit_app/settings.dart';
import 'package:open_transit_app/transit_networks/networks.dart';
import 'package:open_transit_app/transit_networks/selected_network.dart';
import 'package:open_transit_app/utils.dart';
import 'package:open_transit_app/web_utils/web_utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/link.dart';

final _apkDownloadUrl =
    WebUtils.instance?.getBaseUrl()?.resolve('open-transit-app.apk');

class MainScreen extends ConsumerWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Theme.of(context).isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawerScrimColor: Colors.black38,
      drawer: const Drawer(
        child: SafeArea(
          child: _DrawerContent(),
        ),
      ),
      body: Builder(
        builder: (context) {
          return SlidingUpPanel(
            minHeight: 160,
            maxHeight: MediaQuery.sizeOf(context).height -
                MediaQuery.paddingOf(context).top,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
            backdropEnabled: true,
            backdropOpacity: 0,
            color: Theme.of(context).colorScheme.surface,
            panel: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: const SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DragHandle(),
                    _PanelContent(),
                  ],
                ),
              ),
            ),
            body: const CustomMapWidget(),
          );
        },
      ),
    );
  }
}

class _DrawerContent extends ConsumerWidget {
  const _DrawerContent();

  bool _shouldShowAndroidAppDownloadLink() {
    return _apkDownloadUrl != null &&
        defaultTargetPlatform != TargetPlatform.iOS;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_shouldShowAndroidAppDownloadLink())
          _AndroidAppDownloadLink(url: _apkDownloadUrl),
        const Spacer(),
        SwitchListTile(
          title: const Text('Debug info'),
          value: ref.watch(settingsProvider).showDebugInfo,
          onChanged: (value) {
            ref.read(settingsProvider.notifier).setShowDebugInfo(value);
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Center(child: Text('Theme')),
        ),
        Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 0),
          child: SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            selected: {ref.watch(settingsProvider).themeMode},
            onSelectionChanged: (value) {
              ref.read(settingsProvider.notifier).setThemeMode(value.single);
            },
            segments: const [
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('Auto'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
              )
            ],
          ),
        ),
      ],
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

class _PanelContent extends StatelessWidget {
  const _PanelContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FilledButtonTheme(
        data: FilledButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                SizedBox(height: 8.0),
                NetworkSelector(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TopButtons extends StatelessWidget {
  const TopButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childAspectRatio: 2.5,
      clipBehavior: Clip.none,
      children: [
        FilledButton.tonal(
          onPressed: () {},
          style: FilledButtonTheme.of(context).style!.copyWith(
                shape: _createRoundedCornerShape(base: 8.0, topLeft: 16.0),
              ),
          child: const Text('Routes'),
        ),
        FilledButton.tonal(
          onPressed: () {},
          child: const Text('Stops'),
        ),
        FilledButton.tonal(
          onPressed: () {},
          style: FilledButtonTheme.of(context).style!.copyWith(
                shape: _createRoundedCornerShape(base: 8.0, topRight: 16.0),
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
    return DropdownMenu<TransitNetwork>(
      leadingIcon: const Icon(Icons.location_city),
      label: const Text('Location'),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      width: MediaQuery.sizeOf(context).width - 32,
      initialSelection: asyncSelectedNetwork.valueOrNull,
      onSelected: (value) {
        ref.read(selectedNetworkProvider.notifier).select(value);
      },
      dropdownMenuEntries: asyncNetworks.maybeWhen(
        data: (data) => data.map((network) {
          return DropdownMenuEntry<TransitNetwork>(
            value: network,
            label: network.name,
          );
        }).toList(),
        orElse: List.empty,
      ),
    );
  }
}

class _AndroidAppDownloadLink extends StatelessWidget {
  const _AndroidAppDownloadLink({
    required this.url,
  });

  final Uri? url;

  Widget? _buildSubtitle() {
    assert(kIsWeb);
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const Text('for smoother experience');
    }
    return const Text('to monitor on the go');
  }

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: url,
      target: LinkTarget.self,
      builder: (context, followLink) {
        return ListTile(
          title: const Text('Download Android app'),
          subtitle: _buildSubtitle(),
          leading: const Icon(Icons.system_update),
          onTap: followLink,
        );
      },
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    const Size size = Size(32, 4);
    return Semantics(
      label: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      container: true,
      child: SizedBox(
        height: 16,
        width: kMinInteractiveDimension,
        child: Center(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height / 2),
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
