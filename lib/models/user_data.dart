class UserData {
  final String email;
  final String userType;

  UserData({
    required this.email,
    required this.userType,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'] as String,
      userType: json['role'] as String,
    );
  }
}
