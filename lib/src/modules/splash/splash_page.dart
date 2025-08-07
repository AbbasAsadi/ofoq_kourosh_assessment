import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/modules/login/_routes/login_routes.dart';
import 'package:ofoq_kourosh_assessment/src/modules/splash/_bloc/splash_cubit.dart';

import '_bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => SplashCubit()..startTimer(), child: const _SplashPage());
  }
}

class _SplashPage extends StatelessWidget {
  const _SplashPage();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is SplashFinished) {
          LoginRoutes.toLoginPage(context);
        }
      },
      child: Scaffold(body: Center(child: Image.asset(Assets.images.logoSplash.path))),
    );
  }
}
