class User {
  final int id;
  final String userName;

  User({required this.id, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], userName: json['userName']);
  }
}
