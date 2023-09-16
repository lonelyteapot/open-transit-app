import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/main_screen/drawer.dart';
import 'package:open_transit_app/main_screen/map_widget.dart';
import 'package:open_transit_app/utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({
    super.key,
    required this.body,
  });

  static final mapKey = GlobalKey(debugLabel: 'mainCustomMap');

  final double sidebarWidth = 400.0;
  final Widget body;

  Widget _buildPortrait(context) {
    final maxPanelHeight =
        MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).top;
    const borderRadius = BorderRadius.vertical(
      top: Radius.circular(28.0),
    );
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
      backdropEnabled: true,
      backdropOpacity: 0,
      color: Theme.of(context).colorScheme.surface,
      panel: MediaQuery.removePadding(
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
                child: body,
              ),
              const Positioned(
                top: 0,
                child: _DragHandle(),
              ),
            ],
          ),
        ),
      ),
      body: CustomMapWidget(key: mapKey),
    );
  }

  Widget _buildLandscape(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: sidebarWidth,
          right: 0,
          child: CustomMapWidget(key: mapKey),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: sidebarWidth,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: body,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape =
            (constraints.maxWidth + sidebarWidth > constraints.maxHeight);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: isLandscape ? false : true,
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
              child: DrawerContent(),
            ),
          ),
          body: Builder(
            builder: isLandscape ? _buildLandscape : _buildPortrait,
          ),
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
