import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_transit_app/src/core/utils.dart';
import 'package:open_transit_app/src/settings/settings_notifier.dart';

const String _mapboxLightStyleId = 'cllhswcs9018i01qs99zdd7n6';
const String _mapboxDarkStyleId = 'clmb10kfe01ac01pfdic1deec';
const String _mapboxAccessToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

String _buildMapboxUrl({required String styleId, required String accessToken}) {
  return 'https://api.mapbox.com/styles/v1/lonelyteapot/$styleId/tiles/256/{z}/{x}/{y}@2x?access_token=$accessToken';
}

class CustomMapWidget extends ConsumerStatefulWidget {
  const CustomMapWidget({super.key});

  @override
  ConsumerState<CustomMapWidget> createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends ConsumerState<CustomMapWidget> {
  late final MapController _mapController;
  late final StreamController<void> _tileLayerResetController;
  bool? wasDarkMode;

  @override
  void initState() {
    assert(_mapboxAccessToken.isNotEmpty);
    super.initState();
    _mapController = MapController();
    _tileLayerResetController = StreamController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isDarkMode = Theme.of(context).isDark;
    if (wasDarkMode != isDarkMode) {
      if (wasDarkMode != null) {
        resetTileLayer();
      }
      wasDarkMode = isDarkMode;
    }
  }

  void resetTileLayer() {
    _tileLayerResetController.add(null);
    // Prevents instability
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(56.32867, 44.00205),
        minZoom: 2,
        maxZoom: 18,
        backgroundColor:
            Theme.of(context).isDark ? const Color(0xFF292929) : Colors.white,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all &
              ~InteractiveFlag.rotate &
              ~InteractiveFlag.flingAnimation,
        ),
      ),
      mapController: _mapController,
      nonRotatedChildren: [
        // TODO: Add attributions
        // https://docs.mapbox.com/help/getting-started/attribution/
        if (ref.watch(pSettings).showDebugInfo)
          SafeArea(
            child: _buildDebugInfo(),
          ),
      ],
      children: [
        TileLayer(
          tileProvider: CancellableNetworkTileProvider(),
          urlTemplate: _buildMapboxUrl(
            styleId: Theme.of(context).isDark
                ? _mapboxDarkStyleId
                : _mapboxLightStyleId,
            accessToken: _mapboxAccessToken,
          ),
          userAgentPackageName: 'open_transit.open_transit_app',
          maxZoom: 18,
          reset: _tileLayerResetController.stream,
          errorTileCallback: (tile, error, stackTrace) {
            final c = tile.coordinates;
            final errmsg =
                error is DioException ? error.message : error.toString();
            _showErrorSnackBar(
              context,
              'Failed to load a map tile at (${c.x}, ${c.y}, ${c.z}): $errmsg',
            );
          },
          // Custom headers are disallowed due to an issue with CORS in Firefox
        )..tileProvider.headers.remove('User-Agent'),
      ],
    );
  }

  Widget _buildDebugInfo() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Align(
        alignment: Alignment.topCenter,
        child: StreamBuilder(
          stream: _mapController.mapEventStream,
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
