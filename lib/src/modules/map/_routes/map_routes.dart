import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/src/modules/map/map_page.dart';

class MapRoutes {
  static const _mapPagePath = '/map';
  static RouteBase route = GoRoute(
    path: _mapPagePath,
    name: _mapPagePath,
    builder: (_, state) => MapPage(initialPoint: state.extra as LatLng),
  );

  static void toMapPage(BuildContext context, LatLng selectedPoint) {
    context.pushNamed(_mapPagePath, extra: selectedPoint);
  }
}
