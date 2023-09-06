import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_transit_app/private_constants.dart';

class CustomMapWidget extends StatefulWidget {
  const CustomMapWidget({super.key});

  @override
  State<CustomMapWidget> createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends State<CustomMapWidget> {
  late final MapController mapController;
  late final String mapboxUrlTemplate;

  @override
  void initState() {
    super.initState();
    mapboxUrlTemplate =
        'https://api.mapbox.com/styles/v1/lonelyteapot/cllhswcs9018i01qs99zdd7n6/tiles/256/{z}/{x}/{y}{r}?access_token=$MAPBOX_ACCESS_TOKEN';
    mapController = MapController();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      key: const ValueKey('mainMap'),
      options: const MapOptions(
        initialCenter: LatLng(56.32867, 44.00205),
        minZoom: 2,
        maxZoom: 18,
        backgroundColor: Colors.white,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      mapController: mapController,
      nonRotatedChildren: const [
        // TODO: Add attributions
        // https://docs.mapbox.com/help/getting-started/attribution/
      ],
      children: [
        TileLayer(
          urlTemplate: mapboxUrlTemplate,
          userAgentPackageName: 'open_transit.open_transit_app',
          maxZoom: 18,
        ),
      ],
    );
  }
}
