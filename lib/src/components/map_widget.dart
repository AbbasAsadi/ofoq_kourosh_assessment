import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/core/constants/api_constants.dart';
import 'package:ofoq_kourosh_assessment/src/helper/error_handler.dart';
import 'package:ofoq_kourosh_assessment/src/helper/location_helper.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key, required this.initialPoint});

  final LatLng initialPoint;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with ErrorHandler {
  final MapController mapController = MapController();
  LatLng? userLocation;
  ValueNotifier<bool> canGetLocation = ValueNotifier(false);
  ValueNotifier<bool> inLoadingGetUserLocation = ValueNotifier(false);

  @override
  void dispose() {
    mapController.dispose();
    inLoadingGetUserLocation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(initialCenter: widget.initialPoint, initialZoom: 16),
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
        Positioned(
          bottom: 24,
          right: 24,
          child: ValueListenableBuilder<bool>(
            valueListenable: inLoadingGetUserLocation,
            builder: (context, inLoading, child) {
              return Material(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: AppColors.blueSuccessWarningErrorINFO,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: inLoading
                      ? null
                      : () async {
                          String? message =
                              await LocationHelper.checkPermission();
                          if (message == null) {
                            canGetLocation.value = true;
                            inLoadingGetUserLocation.value = true;

                            if (userLocation != null &&
                                mapController.camera.center != userLocation) {
                              mapController.move(userLocation!, 16);
                              inLoadingGetUserLocation.value = false;
                            }
                          } else {
                            showError(context: context, message: message);
                          }
                        },
                  child: Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(12.0),
                    child: (inLoading)
                        ? CircularProgressIndicator(
                            color: AppColors.blueSuccessWarningErrorINFO,
                          )
                        : SvgPicture.asset(Assets.icons.gps),
                  ),
                ),
              );
            },
          ),
        ),

        ValueListenableBuilder<bool>(
          valueListenable: canGetLocation,
          builder: (context, value, child) {
            if (!value) return SizedBox();

            return StreamBuilder<Position>(
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
                      if (userLocation != null &&
                          mapController.camera.center != userLocation) {
                        Future.delayed(Duration(seconds: 1), () {
                          inLoadingGetUserLocation.value = false;
                          mapController.move(userLocation!, 16);
                        });
                      }
                      return CircleLayer(
                        circles: [
                          CircleMarker(
                            point: userLocation!,
                            radius: (data.data?.accuracy ?? 1),
                            color: Colors.lightBlueAccent.withValues(alpha: .3),
                          ),
                          CircleMarker(
                            point: userLocation!,
                            radius: 5,
                            color: Colors.blue,
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                }
              },
            );
          },
        ),
      ],
    );
  }
}
