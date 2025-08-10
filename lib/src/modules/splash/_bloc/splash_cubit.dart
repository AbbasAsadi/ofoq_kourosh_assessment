import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/secure_storage.dart';
import 'package:ofoq_kourosh_assessment/src/modules/splash/_bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    startTimer();
  }

  void startTimer() {
    locator<SecureStorage>().userID.then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        if (value == null) {
          emit(SplashFinishedAndGoToLogin());
        } else {
          emit(SplashFinishedAndGoToHome());
        }
      });
    });
  }
}
