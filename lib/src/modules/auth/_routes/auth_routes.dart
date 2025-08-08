import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/auth_page.dart';

class AuthRoutes {
  static const _authPagePath = '/auth';
  static RouteBase route = GoRoute(
    path: _authPagePath,
    name: _authPagePath,
    builder: (_, _) => const AuthPage(),
  );

  static void toAuthPage(BuildContext context) {
    context.go(_authPagePath);
  }
}
