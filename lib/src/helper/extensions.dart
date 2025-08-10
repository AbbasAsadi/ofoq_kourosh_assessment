import 'package:shamsi_date/shamsi_date.dart';

extension DateModifier on String {
  String get toJalaliDateTime {
    try {
      final dateTime = DateTime.parse(this).toLocal();
      final jalali = Jalali.fromDateTime(dateTime);

      final dateStr =
          '${jalali.year.toString().padLeft(3, '0')}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';
      final timeStr =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

      return '$timeStr   $dateStr';
    } catch (_) {
      return this;
    }
  }
}
