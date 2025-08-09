import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_request_status.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/login_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/signup_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/repository/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = locator();

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequestEvent>(_onLoginRequested);
    on<RegisterRequestEvent>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequestEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final response = await _authRepository.login(
      LoginParams(userName: event.username, password: event.password),
    );
    if (response.data != null) {
      debugPrint('login success: ${response.data.toString()}');
      emit(AuthSuccess(user: response.data));
    } else {
      debugPrint('login failed: ${response.error?.message}');
      emit(AuthFailure(error: 'کاربری با این اطلاعات یافت نشد'));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequestEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await _authRepository.signup(
      SignupParams(userName: event.username, password: event.password),
    );
    if (response.status == ApiRequestStatus.success) {
      emit(AuthSuccess());
    } else {
      emit(
        AuthFailure(error: response.error?.message ?? 'Registration failed'),
      );
    }
  }
}
