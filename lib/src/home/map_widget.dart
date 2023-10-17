import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../core/constants.dart';
import '../core/logging.dart';
import '../core/utils.dart';
import '../settings/settings_provider.dart';
import '../transit_network_selector/selected_network_provider.dart';

const String _mapboxLightStyleId = 'cllhswcs9018i01qs99zdd7n6';
const String _mapboxDarkStyleId = 'clmb10kfe01ac01pfdic1deec';
const String _mapboxAccessToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

final Decimal kWorldCenterLat = Decimal.fromInt(25);
final Decimal kWorldCenterLon = Decimal.fromInt(46);
const double kWorldCenterZoom = 2.0;
const double kDefaultZoom = 12.0;

String _buildMapboxUrl({required String styleId, required String accessToken}) {
  return 'https://api.mapbox.com/styles/v1/lonelyteapot/$styleId/tiles/256/{z}/{x}/{y}{r}?access_token=$accessToken';
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

  void moveTo(LatLng center, {required double zoom}) {
    final fCenter = _formatLatLng(center);
    logger.d('Moving to $fCenter at zoom $zoom');
    _mapController.move(center, zoom);
    final resultCenter = _mapController.camera.center;
    if (resultCenter != center) {
      // TODO: Error handling
      final fResultCenter = _formatLatLng(resultCenter);
      logger.e('Failed to move the map to $fCenter, now at $fResultCenter');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedTransitNetworkProvider, (prev, next) {
      if (prev == null || !prev.hasValue || !next.hasValue) {
        return;
      }
      if (prev.value != next.value) {
        var nextCenterLat = next.valueOrNull?.centerLat;
        var nextCenterLon = next.valueOrNull?.centerLon;
        double? nextZoom = kDefaultZoom;
        if (nextCenterLat == null || nextCenterLon == null) {
          nextCenterLat = kWorldCenterLat;
          nextCenterLon = kWorldCenterLon;
          nextZoom = kWorldCenterZoom;
        }
        moveTo(
          LatLng(nextCenterLat.toDouble(), nextCenterLon.toDouble()),
          zoom: nextZoom,
        );
      }
    });
    return FlutterMap(
      options: MapOptions(
        initialCenter:
            LatLng(kWorldCenterLat.toDouble(), kWorldCenterLon.toDouble()),
        initialZoom: kWorldCenterZoom,
        minZoom: 2,
        maxZoom: 18,
        backgroundColor:
            Theme.of(context).isDark ? const Color(0xFF292929) : Colors.white,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          cursorKeyboardRotationOptions:
              CursorKeyboardRotationOptions.disabled(),
        ),
        onMapReady: () {
          // Move the map to its initial position to avoid bounds issues
          _mapController.move(
            LatLng(kWorldCenterLat.toDouble(), kWorldCenterLon.toDouble()),
            kWorldCenterZoom,
          );
        },
      ),
      mapController: _mapController,
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

String _formatLatLng(LatLng latLng) {
  return '(${latLng.latitude.toStringAsFixed(6)}, ${latLng.longitude.toStringAsFixed(6)})';
}
