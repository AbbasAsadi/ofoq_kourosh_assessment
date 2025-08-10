import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/core/constants/api_constants.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    required this.initialPoint,
    required this.onSelectNewLocation,
  });

  final LatLng? initialPoint;
  final ValueSetter<LatLng> onSelectNewLocation;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng? selectedPoint;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        onLongPress: (tapPosition, point) {
          print(point.toString());
          setState(() {
            selectedPoint = point;
          });
          widget.onSelectNewLocation(point);
        },
        initialCenter: widget.initialPoint ?? LatLng(35.731072, 51.419256),
        initialZoom: 16,
      ),
      children: [
        TileLayer(urlTemplate: ApiConstants.mapURL),
        if (widget.initialPoint != null || selectedPoint != null)
          MarkerLayer(
            markers: [
              Marker(
                rotate: false,
                point: selectedPoint ?? widget.initialPoint!,
                height: 50,
                child: SvgPicture.asset(Assets.icons.mapMarker),
              ),
            ],
          ),
      ],
    );
  }
}
