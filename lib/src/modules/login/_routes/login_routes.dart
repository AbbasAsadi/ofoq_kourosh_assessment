import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/modules/login/login_page.dart';

class LoginRoutes {
  static const _loginPagePath = '/login';
  static RouteBase route = GoRoute(path: _loginPagePath, name: _loginPagePath, builder: (_, _) => const LoginPage());

  static void toLoginPage(BuildContext context) {
    context.go(_loginPagePath);
  }
}
