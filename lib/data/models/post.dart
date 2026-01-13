import 'dart:developer';

class ListPostResponse {
  final List<Post> data;
  final bool success;
  ListPostResponse({required this.data, required this.success});

  factory ListPostResponse.fromJson(Map<String, dynamic> json) {
    return ListPostResponse(
        data: (json['data'] as List).map((i) {
          return Post.fromJson(i);
        }).toList(),
        success: json['success']);
  }
}

class Post {
  final int id;
  final String? contentPost;
  final PostUser user;
  Post({required this.id, this.contentPost, required this.user});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        contentPost: json['contentPost'],
        user: PostUser.fromJson(json['user']));
  }
}

class PostUser {
  final int id;
  final String displayName;
  final String avatarUrl;

  PostUser(
      {required this.id, required this.avatarUrl, required this.displayName});

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
        id: json['id'],
        avatarUrl: json['avatarUrl'],
        displayName: json['displayName']);
  }
}
