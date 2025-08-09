import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/core/routes/app_routes.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_theme.dart';

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            AppColors.white, // Scaffold BackgroundColor from theme
      ),
    );

    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      title: "افق کوروش",
      theme: AppTheme.mainTheme,
      debugShowCheckedModeBanner: false,
      locale: Locale('fa'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('fa')],
      // locale: Locale('fa'),
      // supportedLocales: [Locale('fa')],
      // locale: context.watch<LocaleProvider>().locale,
      // supportedLocales: AppLocalizations.supportedLocales,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
