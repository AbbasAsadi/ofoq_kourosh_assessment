sealed class AuthEvent {}

class LoginRequestEvent extends AuthEvent {
  final String username;
  final String password;

  LoginRequestEvent({required this.username, required this.password});
}

class RegisterRequestEvent extends AuthEvent {
  final String username;
  final String password;

  RegisterRequestEvent({required this.username, required this.password});
}
