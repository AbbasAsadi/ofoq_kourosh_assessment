import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_routes/auth_routes.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_routes/home_routes.dart';
import 'package:ofoq_kourosh_assessment/src/modules/splash/_routes/splash_routes.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_routes/task_detail_route.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'rootNav');

  static GoRouter createRouter(BuildContext context) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: SplashRoutes.splashPagePath,
      debugLogDiagnostics: true,
      routes: [
        SplashRoutes.route,
        AuthRoutes.route,
        HomeRoutes.route,
        TaskDetailRoutes.route,
      ],
    );
  }
}
