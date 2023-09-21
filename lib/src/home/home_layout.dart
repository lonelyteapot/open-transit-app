import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' as provider;
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../core/utils.dart';
import 'drawer_widget.dart';
import 'map_widget.dart';

const double sidebarWidth = 400;

class MainScaffold extends ConsumerWidget {
  const MainScaffold({
    super.key,
    required this.body,
  });

  static final mapKey = GlobalKey(debugLabel: 'mainCustomMap');

  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShowBackButton =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath !=
            '/';
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape =
            constraints.maxWidth + sidebarWidth > constraints.maxHeight;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: !isLandscape,
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
            child: SafeArea(
              child: DrawerContent(),
            ),
          ),
          body: isLandscape
              ? _LandscapeLayout(mapKey: mapKey, child: body)
              : _PortraitLayout(mapKey: mapKey, child: body),
        );
      },
    );
  }
}

class _PortraitLayout extends ConsumerStatefulWidget {
  const _PortraitLayout({
    // ignore: unused_element
    super.key,
    required this.mapKey,
    required this.child,
  });

  final Key mapKey;
  final Widget child;

  @override
  ConsumerState<_PortraitLayout> createState() => _PortraitLayoutState();
}

class _PortraitLayoutState extends ConsumerState<_PortraitLayout> {
  @override
  Widget build(BuildContext context) {
    final maxPanelHeight =
        MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).top;
    const borderRadius = BorderRadius.vertical(
      top: Radius.circular(28),
    );
    return provider.Provider<PanelController?>(
      create: (_) => PanelController(),
      child: Builder(
        builder: (context) {
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
            controller: context.watch<PanelController?>(),
            backdropEnabled: true,
            backdropOpacity: 0,
            color: Theme.of(context).colorScheme.surface,
            panelBuilder: (scrollController) {
              return MediaQuery.removePadding(
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
                        child: provider.InheritedProvider.value(
                          value: scrollController,
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
                            child: widget.child,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 0,
                        child: _DragHandle(),
                      ),
                    ],
                  ),
                ),
              );
            },
            body: CustomMapWidget(key: widget.mapKey),
          );
        },
      ),
    );
  }
}

class _LandscapeLayout extends StatefulWidget {
  const _LandscapeLayout({
    // ignore: unused_element
    super.key,
    required this.mapKey,
    required this.child,
  });

  final Key mapKey;
  final Widget child;

  @override
  State<_LandscapeLayout> createState() => _LandscapeLayoutState();
}

class _LandscapeLayoutState extends State<_LandscapeLayout> {
  late final ScrollController _mainScrollController;

  @override
  void initState() {
    super.initState();
    _mainScrollController = ScrollController();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: sidebarWidth,
          right: 0,
          child: CustomMapWidget(key: widget.mapKey),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: sidebarWidth,
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
            child: provider.InheritedProvider.value(
              value: _mainScrollController,
              child: Theme(
                data: Theme.of(context).copyWith(
                  pageTransitionsTheme: PageTransitionsTheme(
                    builders: Map.fromIterable(
                      TargetPlatform.values,
                      value: (_) => const CupertinoPageTransitionsBuilder(),
                    ),
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    const size = Size(32, 4);
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
