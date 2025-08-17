import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class LocationState extends Equatable {
  final LatLng? userLocation; // موقعیت فعلی کاربر (از GPS)
  final double? accuracy; // دقت GPS
  final LatLng? markerPoint; // مارکر انتخابی (initialPoint یا انتخاب جدید)
  final bool tracking; // آیا استریم موقعیت فعال است؟
  final bool loading; // وضعیت لودینگ برای دکمه GPS
  final String? error; // پیام خطا (permission و...)

  const LocationState({
    required this.userLocation,
    required this.accuracy,
    required this.markerPoint,
    required this.tracking,
    required this.loading,
    required this.error,
  });

  factory LocationState.initial({LatLng? markerPoint}) => LocationState(
    userLocation: null,
    accuracy: null,
    markerPoint: markerPoint,
    tracking: false,
    loading: false,
    error: null,
  );

  LocationState copyWith({
    LatLng? userLocation,
    double? accuracy,
    LatLng? markerPoint,
    bool? tracking,
    bool? loading,
    String? error, // برای پاک‌سازی، مقدار null هم قابل قبول است
  }) {
    return LocationState(
      userLocation: userLocation ?? this.userLocation,
      accuracy: accuracy ?? this.accuracy,
      markerPoint: markerPoint ?? this.markerPoint,
      tracking: tracking ?? this.tracking,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    userLocation,
    accuracy,
    markerPoint,
    tracking,
    loading,
    error,
  ];
}
