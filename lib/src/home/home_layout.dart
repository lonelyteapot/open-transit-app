import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../core/providers.dart';
import '../core/utils.dart';
import '../map/map_widget.dart';
import '../transit_network_selector/selected_network_provider.dart';
import '../transit_network_selector/selector_widget.dart';
import 'drawer_widget.dart';

const double kSidebarWidth = 400;

class MainScaffold extends ConsumerWidget {
  const MainScaffold({
    super.key,
    required this.body,
  });

  static final mapKey = GlobalKey(debugLabel: 'mainMap');

  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShowBackButton =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath !=
            '/';
    final map = CustomMapWidget(key: mapKey);
    return LayoutBuilder(
      builder: (context, constraints) {
        final orientation = constraints.maxWidth > 2 * kSidebarWidth
            ? Orientation.landscape
            : Orientation.portrait;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: orientation == Orientation.portrait,
            forceMaterialTransparency: true,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  Theme.of(context).isDark ? Brightness.light : Brightness.dark,
            ),
            leading: shouldShowBackButton
                ? BackButton(onPressed: context.pop)
                : null,
          ),
          drawerScrimColor: Colors.black38,
          endDrawerEnableOpenDragGesture: false,
          endDrawer: const Drawer(
            elevation: 0.5,
            child: SafeArea(
              child: DrawerContent(),
            ),
          ),
          body: _BodyWrapper(
            child: _OrientedLayout(
              orientation: orientation,
              map: map,
              child: body,
            ),
          ),
        );
      },
    );
  }
}

class _BodyWrapper extends ConsumerWidget {
  const _BodyWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wrappedSelectedNetwork = ref.watch(selectedTransitNetworkProvider);
    if (wrappedSelectedNetwork.valueOrNull == null) {
      // TODO: Solve this navigation hell somehow
      return Stack(
        children: [
          child,
          LocationSwitcher(),
        ],
      );
    }
    return child;
  }
}

class _OrientedLayout extends ConsumerWidget {
  const _OrientedLayout({
    // ignore: unused_element
    super.key,
    required this.orientation,
    required this.map,
    required this.child,
  });

  final Orientation orientation;
  final Widget map;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (orientation) {
      case Orientation.portrait:
        return _buildPortrait(context);
      case Orientation.landscape:
        return _buildLandscape(context, ref);
    }
  }

  Widget _buildPortrait(BuildContext context) {
    final maxPanelHeight =
        MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).top;
    const borderRadius = BorderRadius.vertical(
      top: Radius.circular(28),
    );
    return ProviderScope(
      overrides: [
        slidingPanelControllerProvider.overrideWith((ref) => PanelController()),
      ],
      child: Consumer(
        builder: (context, ref, _) {
          // TODO: Solve this navigation hell somehow
          final wrappedSelectedNetwork =
              ref.watch(selectedTransitNetworkProvider);
          if (wrappedSelectedNetwork.valueOrNull == null) {
            return map;
          }
          return SlidingUpPanel(
            minHeight: 160,
            maxHeight: maxPanelHeight,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
            controller: ref.watch(slidingPanelControllerProvider),
            backdropEnabled: true,
            backdropOpacity: 0,
            color: Theme.of(context).colorScheme.surface,
            panelBuilder: (scrollController) {
              return ProviderScope(
                overrides: [
                  primaryScrollControllerProvider
                      .overrideWithValue(scrollController),
                ],
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: SafeArea(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: borderRadius,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              pageTransitionsTheme: PageTransitionsTheme(
                                builders: Map.fromIterable(
                                  TargetPlatform.values,
                                  value: (_) =>
                                      const FadeUpwardsPageTransitionsBuilder(),
                                ),
                              ),
                            ),
                            child: child,
                          ),
                        ),
                        const Positioned(
                          top: 0,
                          child: _DragHandle(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            body: map,
          );
        },
      ),
    );
  }

  Widget _buildLandscape(BuildContext context, WidgetRef ref) {
    // TODO: Solve this navigation hell somehow
    final wrappedSelectedNetwork = ref.watch(selectedTransitNetworkProvider);
    if (wrappedSelectedNetwork.valueOrNull == null) {
      return map;
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: kSidebarWidth,
          right: 0,
          child: map,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: kSidebarWidth,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                pageTransitionsTheme: PageTransitionsTheme(
                  builders: Map.fromIterable(
                    TargetPlatform.values,
                    value: (_) => const CupertinoPageTransitionsBuilder(),
                  ),
                ),
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class _DragHandle extends ConsumerWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const size = Size(32, 4);
    return GestureDetector(
      onTap: () async {
        final panelController = ref.read(slidingPanelControllerProvider)!;
        if (panelController.panelPosition < 0.5) {
          await panelController.open();
        } else {
          await panelController.close();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
      ),
    );
  }
}
