import 'package:flutter/material.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies().then((value) => runApp(const App()));
}
