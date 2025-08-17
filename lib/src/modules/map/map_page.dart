import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/src/components/map_widget.dart';
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
      body: MapWidget(initialPoint: initialPoint),
    );
  }
}
