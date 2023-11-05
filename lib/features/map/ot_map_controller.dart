import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:open_transit_app/utils/logging.dart';

final LatLngBounds kWorldBounds = LatLngBounds(
  const LatLng(-90, -180),
  const LatLng(90, 180),
);

/// (Center of northest 2/3s of the world) - (epsilon to account for float math)
final LatLngBounds kDefaultBounds = LatLngBounds(
  const LatLng(-66, -179),
  const LatLng(89, 179),
);

class OtMapController {
  OtMapController()
      : impl = MapController(),
        tileLayerResetControllerImpl = StreamController();

  final MapController impl;
  final StreamController<void> tileLayerResetControllerImpl;

  LatLng get center => impl.camera.center;
  double get zoom => impl.camera.zoom;

  void teleportCamera(LatLng center, {required double zoom}) {
    final fCenter = formatCameraPosition(center, zoom);
    logger.d('Map camera teleporting to $fCenter');

    if (center == this.center && zoom == this.zoom) {
      logger.d('Map is already there');
      return;
    }

    impl.move(center, zoom);
  }

  void teleportCameraInsideBounds(LatLngBounds bounds) {
    final fCorner1 = formatCameraPosition(bounds.northEast, null);
    final fCorner2 = formatCameraPosition(bounds.southWest, null);
    logger.d('Fitting map camera inside $fCorner1, $fCorner2');

    if (impl.camera.visibleBounds == bounds) {
      logger.d('Map is already there');
      return;
    }

    impl.fitCamera(CameraFit.insideBounds(bounds: bounds));
  }

  void teleportCameraToDefault() {
    teleportCameraInsideBounds(
      kDefaultBounds,
    );
  }

  void resetTiles() {
    // Schedule for next tick for stability
    Future.delayed(Duration.zero, () {
      tileLayerResetControllerImpl.add(null);
    });
  }

  void dispose() {
    impl.dispose();
  }
}

String formatCameraPosition(LatLng latLng, double? zoom) {
  final lat = latLng.latitude.toStringAsFixed(6);
  final lon = latLng.longitude.toStringAsFixed(6);
  final zoomPart = zoom == null ? '' : '@$zoom';
  return '($lat, $lon)$zoomPart';
}
