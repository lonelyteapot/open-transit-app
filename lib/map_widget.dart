import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_transit_app/utils.dart';

class CustomMapWidget extends StatefulWidget {
  const CustomMapWidget({super.key});

  @override
  State<CustomMapWidget> createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends State<CustomMapWidget> {
  late final MapController _mapController;
  late final StreamController<void> _tileLayerResetController;
  bool? wasDarkMode;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _tileLayerResetController = StreamController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void resetTileLayer() {
    _tileLayerResetController.add(null);
  }

  void maybeDarkModeUpdated(final bool isDarkMode) {
    if (wasDarkMode == null) {
      wasDarkMode = isDarkMode;
      return;
    }
    if (wasDarkMode != isDarkMode) {
      resetTileLayer();
      wasDarkMode = isDarkMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    maybeDarkModeUpdated(context.isDarkMode);
    final mapboxStyleId = context.isDarkMode
        ? 'clmb10kfe01ac01pfdic1deec'
        : 'cllhswcs9018i01qs99zdd7n6';
    const mapboxAccessToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');
    assert(mapboxAccessToken.isNotEmpty);
    final mapboxUrlTemplate =
        'https://api.mapbox.com/styles/v1/lonelyteapot/$mapboxStyleId/tiles/256/{z}/{x}/{y}@2x?access_token=$mapboxAccessToken';
    return Container(
      // Workaround: MapOptions.backgroundColor doesn't like to update on
      // rebuilds for some reason, so it's set to transparent instead
      color: context.isDarkMode ? const Color(0xFF292929) : Colors.white,
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(56.32867, 44.00205),
          minZoom: 2,
          maxZoom: 18,
          backgroundColor: Colors.transparent,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.all &
                ~InteractiveFlag.rotate &
                ~InteractiveFlag.flingAnimation,
          ),
        ),
        mapController: _mapController,
        nonRotatedChildren: const [
          // TODO: Add attributions
          // https://docs.mapbox.com/help/getting-started/attribution/
        ],
        children: [
          TileLayer(
            tileProvider: CancellableNetworkTileProvider(),
            urlTemplate: mapboxUrlTemplate,
            userAgentPackageName: 'open_transit.open_transit_app',
            maxZoom: 18,
            reset: _tileLayerResetController.stream,
            // Custom headers are disallowed due to an issue with CORS in Firefox
          )..tileProvider.headers.remove('User-Agent'),
        ],
      ),
    );
  }
}
