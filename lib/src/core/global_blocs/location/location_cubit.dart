import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/src/core/global_blocs/location/location_state.dart';
import 'package:ofoq_kourosh_assessment/src/helper/location_helper.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({LatLng? initialMarker})
    : super(LocationState.initial(markerPoint: initialMarker));

  StreamSubscription<Position>? _locationSub;

  /// شروع/ادامه‌ی دریافت لوکیشن کاربر
  Future<void> startTracking() async {
    // اگر در حال لود بودیم، بیخیال دوباره کال شدن
    if (state.loading) return;

    emit(state.copyWith(loading: true, error: null));

    final message = await LocationHelper.checkPermission();
    if (message != null) {
      emit(state.copyWith(loading: false, error: message, tracking: false));
      return;
    }

    // اگر قبلاً استریم راه افتاده، رهاش کن
    await _locationSub?.cancel();

    _locationSub =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100, // مثل کد قبلیت
          ),
        ).listen(
          (pos) {
            final userLatLng = LatLng(pos.latitude, pos.longitude);
            emit(
              state.copyWith(
                userLocation: userLatLng,
                accuracy: pos.accuracy,
                loading: false,
                tracking: true,
                error: null,
              ),
            );
          },
          onError: (e) {
            emit(state.copyWith(loading: false, error: e.toString()));
          },
          cancelOnError: false,
        );
  }

  /// توقف دریافت لوکیشن
  Future<void> stopTracking() async {
    await _locationSub?.cancel();
    _locationSub = null;
    emit(state.copyWith(tracking: false));
  }

  /// انتخاب نقطه جدید روی نقشه (onLongPress)
  void selectMarker(LatLng point) {
    emit(state.copyWith(markerPoint: point));
  }

  /// پاک کردن خطا (بعد از نمایش Snackbar)
  void clearError() {
    if (state.error != null) {
      emit(state.copyWith(error: null));
    }
  }

  @override
  Future<void> close() async {
    await _locationSub?.cancel();
    return super.close();
  }
}
