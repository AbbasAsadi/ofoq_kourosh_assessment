import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/modules/login/_routes/login_routes.dart';
import 'package:ofoq_kourosh_assessment/src/modules/splash/_routes/splash_routes.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNav');

  static GoRouter createRouter(BuildContext context) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: SplashRoutes.splashPagePath,
      debugLogDiagnostics: true,
      routes: [SplashRoutes.route, LoginRoutes.route],
    );
  }
}
