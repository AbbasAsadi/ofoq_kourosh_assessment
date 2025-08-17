import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/core/constants/api_constants.dart';
import 'package:ofoq_kourosh_assessment/src/core/global_blocs/location/location_cubit.dart';
import 'package:ofoq_kourosh_assessment/src/core/global_blocs/location/location_state.dart';
import 'package:ofoq_kourosh_assessment/src/helper/error_handler.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    required this.initialPoint,
    this.onSelectNewLocation,
    this.fetchLocationButtonBottomPadding = 24,
  });

  final LatLng? initialPoint;
  final ValueSetter<LatLng>? onSelectNewLocation;
  final double fetchLocationButtonBottomPadding;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with ErrorHandler {
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit(initialMarker: widget.initialPoint),
      child: BlocListener<LocationCubit, LocationState>(
        listenWhen: (prev, curr) =>
            prev.error != curr.error && curr.error != null,
        listener: (context, state) {
          if (state.error != null) {
            showError(context: context, message: state.error!);
            context.read<LocationCubit>().clearError();
          }
        },
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            // اگر لوکیشن جدیدی رسید و مرکز نقشه جای دیگه‌ایه، حرکت کنیم
            if (state.userLocation != null &&
                _mapController.camera.center != state.userLocation) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // کمی تاخیر مثل کد قبلیت
                Future.delayed(const Duration(seconds: 1), () {
                  _mapController.move(state.userLocation!, 16);
                });
              });
            }

            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter:
                    widget.initialPoint ?? const LatLng(35.731072, 51.419256),
                initialZoom: 16,
                onLongPress: widget.onSelectNewLocation == null
                    ? null
                    : (tapPosition, point) {
                        context.read<LocationCubit>().selectMarker(point);
                        widget.onSelectNewLocation?.call(point);
                      },
              ),
              children: [
                TileLayer(urlTemplate: ApiConstants.mapURL),

                // مارکر انتخابی (یا initial)
                if (state.markerPoint != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: state.markerPoint!,
                        height: 50,
                        child: SvgPicture.asset(Assets.icons.mapMarker),
                      ),
                    ],
                  ),

                // لایه‌ی نشان‌دهنده‌ی لوکیشن کاربر و accuracy
                if (state.userLocation != null)
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: state.userLocation!,
                        radius: (state.accuracy ?? 1),
                        color: Colors.lightBlueAccent.withValues(alpha: .3),
                      ),
                      CircleMarker(
                        point: state.userLocation!,
                        radius: 5,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                // دکمه‌ی GPS (گرفتن لوکیشن کاربر)
                Positioned(
                  bottom: widget.fetchLocationButtonBottomPadding,
                  right: 24,
                  child: Material(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: AppColors.blueSuccessWarningErrorINFO,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: state.loading
                          ? null
                          : () async {
                              // شروع/ادامه‌ی دریافت لوکیشن
                              await context
                                  .read<LocationCubit>()
                                  .startTracking();

                              // اگر همین الان لوکیشن داریم، سریع مرکز نقشه رو ببر همون‌جا
                        final userLoc = context
                            .read<LocationCubit>()
                            .state
                            .userLocation;
                        if (userLoc != null &&
                            _mapController.camera.center != userLoc) {
                          _mapController.move(userLoc, 16);
                        }
                      },
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: state.loading
                              ? CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.blueSuccessWarningErrorINFO,
                          )
                              : SvgPicture.asset(Assets.icons.gps),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
