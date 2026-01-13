import 'dart:developer';

import 'package:flutter/material.dart';

class TextContentWidget extends StatefulWidget {
  final String postContent;
  const TextContentWidget({super.key, required this.postContent});

  @override
  State<TextContentWidget> createState() => _TextContentWidgetState();
}

class _TextContentWidgetState extends State<TextContentWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    log(isExpanded.toString());
    return InkWell(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Text(
        widget.postContent,
        maxLines: !isExpanded ? 3 : null,
        overflow: !isExpanded ? TextOverflow.ellipsis : TextOverflow.visible,
      ),
    );
  }
}
