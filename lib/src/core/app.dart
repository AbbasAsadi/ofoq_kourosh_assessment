import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/core/routes/app_routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GoRouter _router;

  @override
  void initState() {
    if (mounted) _router = AppRoutes.createRouter(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      title: "ofoq kourosh",
      // theme: AppTheme.mainTheme,
      debugShowCheckedModeBanner: false,
      // locale: context.watch<LocaleProvider>().locale,
      // supportedLocales: AppLocalizations.supportedLocales,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
