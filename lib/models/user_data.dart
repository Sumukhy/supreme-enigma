class UserData {
  final String email;

  UserData({
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'] as String,
    );
  }
}
