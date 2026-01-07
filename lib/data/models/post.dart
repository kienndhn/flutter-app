class Post {
  final int id;
  Post({required this.id});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id']);
  }
}
