import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../core/constants.dart';
import '../core/utils.dart';
import '../settings/settings_model.dart';
import '../settings/settings_provider.dart';
import '../transit_network_selector/current_network_provider.dart';
import '../transit_networks/network_model.dart';
import 'ot_map_controller.dart';
import 'ot_map_controller_provider.dart';

const String _mapboxLightStyleId = 'cllhswcs9018i01qs99zdd7n6';
const String _mapboxDarkStyleId = 'clmb10kfe01ac01pfdic1deec';
const String _mapboxAccessToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

const double kDefaultZoom = 12.0;
const double kInitialZoom = 3.0;

String _buildMapboxUrl({required String styleId, required String accessToken}) {
  return 'https://api.mapbox.com/styles/v1/lonelyteapot/$styleId/tiles/256/{z}/{x}/{y}{r}?access_token=$accessToken';
}

class CustomMapWidget extends ConsumerStatefulWidget {
  const CustomMapWidget({super.key});

  @override
  ConsumerState<CustomMapWidget> createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends ConsumerState<CustomMapWidget> {
  bool? wasDarkMode;

  late final OtMapController mapController;

  @override
  void initState() {
    assert(_mapboxAccessToken.isNotEmpty);
    super.initState();
    mapController = ref.read(otMapControllerProvider);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isDarkMode = Theme.of(context).isDark;
    if (wasDarkMode != isDarkMode) {
      if (wasDarkMode != null) {
        mapController.resetTiles();
      }
      wasDarkMode = isDarkMode;
    }
  }

  void _handleMapReady() {
    // Schedule for next tick for stability
    Future.delayed(Duration.zero, () {
      // Try to avoid bounding issues
      mapController.teleportCameraToDefault();
    });
  }

  void _handleTileError(TileImage tile, Object error, StackTrace? stackTrace) {
    final pos = tile.coordinates;
    final errmsg = error is DioException ? error.message : error.toString();
    _showErrorSnackBar(
      context,
      'Failed to load map tile at (${pos.x}, ${pos.y}, ${pos.z}): $errmsg',
    );
  }

  void _handleCurrentTransitNetworkChange(
    AsyncValue<TransitNetwork?>? prev,
    AsyncValue<TransitNetwork?> next,
  ) {
    if (prev == null) {
      return;
    }
    if (!(prev.hasValue && next.hasValue)) {
      return;
    }
    if (prev.value != next.value) {
      var nextCenterLat = next.valueOrNull?.centerLat;
      var nextCenterLon = next.valueOrNull?.centerLon;
      double? nextZoom = kDefaultZoom;
      if (nextCenterLat == null || nextCenterLon == null) {
        mapController.teleportCameraToDefault();
      } else {
        mapController.teleportCamera(
          LatLng(nextCenterLat.toDouble(), nextCenterLon.toDouble()),
          zoom: nextZoom,
        );
      }
    }
  }

  void _handleSettingsChange(SettingsData? prev, SettingsData next) {
    if (prev == null) {
      return;
    }
    if (prev.themeMode != next.themeMode) {
      mapController.resetTiles();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      currentTransitNetworkProvider,
      _handleCurrentTransitNetworkChange,
    );
    ref.listen(settingsProvider, _handleSettingsChange);
    return FlutterMap(
      options: MapOptions(
        initialCenter: kWorldBounds.center,
        initialZoom: kInitialZoom,
        minZoom: 2,
        maxZoom: 18,
        // Unhotfix for https://github.com/fleaflet/flutter_map/pull/1700
        // that constraints the camera.
        // This isn't much of an issue now because rotation is disabled.
        // TODO: Remove when the issue is fixed.
        cameraConstraint: CameraConstraint.contain(bounds: kWorldBounds),
        backgroundColor:
            Theme.of(context).isDark ? const Color(0xFF292929) : Colors.white,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          cursorKeyboardRotationOptions:
              CursorKeyboardRotationOptions.disabled(),
        ),
        onMapReady: _handleMapReady,
      ),
      mapController: mapController.impl,
      children: [
        TileLayer(
          tileProvider: ref.watch(settingsProvider).useCancellableTileProvider
              ? CancellableNetworkTileProvider()
              : NetworkTileProvider(),
          urlTemplate: _buildMapboxUrl(
            styleId: Theme.of(context).isDark
                ? _mapboxDarkStyleId
                : _mapboxLightStyleId,
            accessToken: _mapboxAccessToken,
          ),
          userAgentPackageName: kUserAgentPackageName,
          maxZoom: 18,
          retinaMode: true,
          reset: mapController.tileLayerResetControllerImpl.stream,
          errorTileCallback: _handleTileError,
        ),
        // TODO: Add attributions
        // https://docs.mapbox.com/help/getting-started/attribution/
        if (ref.watch(settingsProvider).showDebugInfo)
          SafeArea(
            child: _buildDebugInfo(),
          ),
      ],
    );
  }

  Widget _buildDebugInfo() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Align(
        alignment: Alignment.topCenter,
        child: StreamBuilder(
          stream: mapController.impl.mapEventStream,
          builder: (context, snapshot) {
            final zoom = snapshot.data?.camera.zoom;
            final center = snapshot.data?.camera.center;
            final centerLat = center?.latitude.toStringAsFixed(6);
            final centerLon = center?.longitude.toStringAsFixed(6);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText('Center: $centerLat, $centerLon'),
                SelectableText('Zoom: ${zoom?.toStringAsFixed(4)}'),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showErrorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.error,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(minutes: 1),
    ),
  );
}
