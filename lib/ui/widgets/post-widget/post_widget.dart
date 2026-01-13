import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template_app/data/models/post.dart';
import 'package:flutter_template_app/ui/widgets/cached_image_widget.dart';
import 'package:flutter_template_app/ui/widgets/post-widget/text_content_widget.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final int index;
  const PostWidget({
    super.key,
    required this.post,
    required this.index,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy giá trị top (phần tai thỏ, status bar)
    double topPadding = MediaQuery.of(context).padding.top;

    // Lấy giá trị bottom (phần thanh điều hướng, nút home ảo)
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.amber : Colors.amberAccent,
      ),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
              padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          CachedAvatar(imageUrl: widget.post.user.avatarUrl),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(widget.post.user.displayName)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextContentWidget(
                          postContent: widget.post.contentPost ?? "")
                    ],
                  )))),
    );
  }
}
