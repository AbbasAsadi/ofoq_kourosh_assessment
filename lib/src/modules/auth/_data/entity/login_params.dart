class LoginParams {
  final String userName;
  final String password;

  LoginParams({required this.userName, required this.password});

  Map<String, dynamic> toJson() {
    return {"Username": "eq.$userName", "Password": "eq.$password"};
  }
}
