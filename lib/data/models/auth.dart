class Auth {
  final String accessToken;
  final String refreshToken;
  final String userName;

  Auth(
      {required this.accessToken,
      required this.refreshToken,
      required this.userName});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        userName: json['userName']);
  }
}
