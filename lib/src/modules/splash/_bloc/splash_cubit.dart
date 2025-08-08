import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ofoq_kourosh_assessment/src/modules/splash/_bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      emit(SplashFinished());
    });
  }
}
