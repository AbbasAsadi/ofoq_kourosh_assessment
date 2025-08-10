import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';

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
        // Center the map over London
        initialZoom: 16,
      ),
      children: [
        TileLayer(
          urlTemplate:
              "https://map.ir/shiveh/xyz/1.0.0/Shiveh:Shiveh@EPSG:3857@png/{z}/{x}/{y}.png"
              "?x-api-key=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImJiOGUwYzJlZjMzMzMxNzk1YWRlZjY1YjhkMTdlYmE4Mzk2ZTk1MzE3MWFlNWJmNzQ3ZDFjMjE4NTFkMzgyZTllNTQ3MTc0YTIzOGQ0MTYyIn0.eyJhdWQiOiIzMzc3NCIsImp0aSI6ImJiOGUwYzJlZjMzMzMxNzk1YWRlZjY1YjhkMTdlYmE4Mzk2ZTk1MzE3MWFlNWJmNzQ3ZDFjMjE4NTFkMzgyZTllNTQ3MTc0YTIzOGQ0MTYyIiwiaWF0IjoxNzU0ODU2NjU5LCJuYmYiOjE3NTQ4NTY2NTksImV4cCI6MTc1NzQ0ODY1OSwic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.INyuntjtkVQsA1LEXoaU2HVqkxfrY_GXA1IWLagWYwigmOpFRbAKI0WaalIln6_7_2hEwPWkOMazD88gGeXb49sygJ_F2u0Fhfq7nABED5bRsw5b_TFppCE6zGTKPJPirnMk0nFbcGxRCxxWxa3TCyj5QCfX2h-AtE4Dpj8ltPvUqfjnFeouO2PFrCDIpHIYldhHFYR2M5mCLG5t6jhvFxz1M8bD4JmiCt1HtaOd0vbybSYYexKDDicorCVVPngytioNagom-fA-n9PMEy_2YDoxBiAEp7Dyo3JL5jumXD9Gdi5fcnFiH5S57UAHydy_-AMENNlxcm_DX7ttNtLESQ",
        ),
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
