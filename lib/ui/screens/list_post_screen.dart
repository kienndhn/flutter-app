import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template_app/core/services/post_service.dart';
import 'package:flutter_template_app/data/models/post.dart';
import 'package:flutter_template_app/ui/widgets/post-widget/post_widget.dart';

class ListPostScreen extends StatefulWidget {
  const ListPostScreen({super.key});

  // 2. Biến lưu trữ Future

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {
  final PostService _postService = PostService();

  late Future<ListPostResponse> _postFuture;

  @override
  void initState() {
    super.initState();
    // 3. Gọi API ngay khi vào màn hình
    _postFuture = _postService.getListPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Bài viết"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              MediaQuery.removePadding(
                  context: context,
                  child: Expanded(
                    child: FutureBuilder(
                        future: _postFuture,
                        builder: (context, snapshot) {
                          // 1. Trạng thái đang tải
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          // 2. Trạng thái có lỗi xảy ra
                          if (snapshot.hasError) {
                            log('Lỗi Snapshot: ${snapshot.error}');
                            return const Center(
                                child: Text('Đã có lỗi xảy ra!'));
                          }

                          // 3. Trạng thái có dữ liệu
                          if (snapshot.hasData &&
                              snapshot.data!.data.isNotEmpty) {
                            final posts =
                                snapshot.data!.data; // Lấy danh sách PostItem

                            return RefreshIndicator(
                              onRefresh: () async {
                                setState(() {
                                  _postFuture = _postService.getListPost();
                                });
                              },
                              child: ListView.builder(
                                physics: const PageScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  return PostWidget(
                                    post: posts[index],
                                    index: index,
                                  );
                                },
                              ),
                            );
                          }

                          return const Center(child: Text("Không có bài viết"));
                        }),
                  ))
            ],
          ),
        ));
  }
}
