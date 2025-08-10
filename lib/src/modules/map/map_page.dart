import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/core/constants/api_constants.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key, required this.initialPoint});

  final LatLng initialPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('نمایش موقعیت', style: context.textTheme.bodyLarge),
      ),
      body: FlutterMap(
        options: MapOptions(initialCenter: initialPoint, initialZoom: 16),
        children: [
          TileLayer(urlTemplate: ApiConstants.mapURL),
          MarkerLayer(
            markers: [
              Marker(
                rotate: false,
                point: initialPoint,
                height: 50,
                child: SvgPicture.asset(Assets.icons.mapMarker),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
