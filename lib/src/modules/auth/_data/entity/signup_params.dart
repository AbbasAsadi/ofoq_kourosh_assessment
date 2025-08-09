class SignupParams {
  final String userName;
  final String password;

  SignupParams({required this.userName, required this.password});

  Map<String, dynamic> toJson() {
    return {"Username": userName, "Password": password};
  }
}
