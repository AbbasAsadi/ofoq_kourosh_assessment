import 'package:flutter/material.dart';

extension ContextBaseExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  void get closeAppBottomSheet {
    if (mounted) Navigator.of(this, rootNavigator: true).pop();
  }
}
