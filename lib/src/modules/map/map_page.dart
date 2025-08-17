import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/core/constants/api_constants.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/helper/error_handler.dart';
import 'package:ofoq_kourosh_assessment/src/helper/location_helper.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.initialPoint});

  final LatLng initialPoint;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with ErrorHandler {
  final MapController mapController = MapController();
  LatLng? userLocation;
  bool clearToRequestUserLocation = false;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('نمایش موقعیت', style: context.textTheme.bodyLarge),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.blueSuccessWarningErrorINFO),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            String? message = await LocationHelper.checkPermission();
            if (message == null) {
              setState(() {
                clearToRequestUserLocation = true;
              });

              Future.delayed(Duration(seconds: 2), () {
                if (userLocation != null) {
                  mapController.move(userLocation!, 16);
                }
              });
            } else {
              showError(context: context, message: message);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SvgPicture.asset(Assets.icons.gps),
          ),
        ),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: widget.initialPoint,
          initialZoom: 16,
        ),
        children: [
          TileLayer(urlTemplate: ApiConstants.mapURL),
          MarkerLayer(
            markers: [
              Marker(
                rotate: false,
                point: widget.initialPoint,
                height: 50,
                child: SvgPicture.asset(Assets.icons.mapMarker),
              ),
            ],
          ),
          if (clearToRequestUserLocation)
            StreamBuilder(
              stream: Geolocator.getPositionStream(
                locationSettings: LocationSettings(
                  accuracy: LocationAccuracy.high,
                  distanceFilter: 100,
                ),
              ),
              builder: (context, data) {
                switch (data.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return SizedBox();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (data.hasData) {
                      userLocation = LatLng(
                        data.data!.latitude,
                        data.data!.longitude,
                      );
                      return CircleLayer(
                        circles: [
                          CircleMarker(
                            point: userLocation!,
                            radius: (data.data?.accuracy ?? 1),
                            color: Colors.lightBlueAccent.withValues(alpha: .3),
                          ),
                          CircleMarker(
                            point: userLocation!,
                            radius: 7,
                            color: Colors.blue,
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                }
              },
            ),
        ],
      ),
    );
  }
}
