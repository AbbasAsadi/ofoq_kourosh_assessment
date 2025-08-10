import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/home_page.dart';

class HomeRoutes {
  static const _homePagePath = '/home';
  static RouteBase route = GoRoute(
    path: _homePagePath,
    name: _homePagePath,
    builder: (_, _) => const HomePage(),
  );

  static void toHomePage(BuildContext context) {
    context.go(_homePagePath);
  }
}
