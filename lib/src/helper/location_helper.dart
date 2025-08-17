import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<String?> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.value('سرویس لوکیشن فعال نیست');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return Future.value(null);
    } else {
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return 'دسترسی به سرویس لوکیشن مسدود می باشد. لطفا از تنظیمات-> دسترسی ها، اجازه دسترسی را صادر کنید';
        } else {
          return Future.value(null);
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return 'دسترسی به سرویس لوکیشن مسدود می باشد. لطفا از تنظیمات-> دسترسی ها، اجازه دسترسی را صادر کنید';
      }
      return 'خطای ناشناخته در دریافت لوکیشن کاربر';
    }
  }
}
