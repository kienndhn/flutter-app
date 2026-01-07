import 'package:flutter/material.dart';
import 'package:flutter_template_app/core/services/post_service.dart';
import 'package:flutter_template_app/data/models/post.dart';
import 'package:go_router/go_router.dart';

class ListPostScreen extends StatefulWidget {
  // 2. Biến lưu trữ Future

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {
  final PostService _postService = PostService();

  late Future<List<Post>> _postFuture;

  @override
  void initState() {
    super.initState();
    // 3. Gọi API ngay khi vào màn hình
    _postFuture = _postService.getListPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bài viết"),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              FutureBuilder(
                  future: _postFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(itemBuilder: (context, index) {
                        return Text(snapshot.data![index].id.toString());
                      });
                    }
                    final posts = snapshot.data!;

                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _postFuture = _postService.getListPost();
                        });
                      },
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return ListTile(
                            leading: CircleAvatar(child: Text("${index + 1}")),
                            title:
                                Text(post.id.toString() ?? "Không có tiêu đề"),
                            subtitle: Text(post.id.toString() ?? ""),
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
