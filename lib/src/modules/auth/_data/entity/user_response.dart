class UserResponse {
  String token;
  String? userName;
  int? id;

  UserResponse({required this.token, this.userName, this.id});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    token:
        json['token'] ??
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJicmpua3doZG9wdGprcGhzbHlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQzOTExNDgsImV4cCI6MjA2OTk2NzE0OH0.maV-pvQlsHBu-nHA0zv9LtEusljU02IpH873gU66iDQ',
    userName: json['Username'],
    id: json['id'],
  );

  @override
  String toString() {
    return "UserResponse(token: $token, userName: $userName, id: $id)";
  }
}
