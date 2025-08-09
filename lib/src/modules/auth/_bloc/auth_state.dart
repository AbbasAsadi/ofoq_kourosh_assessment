import 'package:equatable/equatable.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/user_response.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserResponse? user;

  AuthSuccess({this.user});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
