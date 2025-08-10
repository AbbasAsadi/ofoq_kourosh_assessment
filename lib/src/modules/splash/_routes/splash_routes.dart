import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/modules/splash/splash_page.dart';

class SplashRoutes {
  static const splashPagePath = '/';
  static RouteBase route = GoRoute(
    path: splashPagePath,
    name: splashPagePath,
    builder: (_, _) => const SplashPage(),
  );

  static void pushReplacementSplashPage(BuildContext context) {
    context.go(splashPagePath);
  }
}
