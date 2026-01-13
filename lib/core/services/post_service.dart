import 'dart:math';

import 'package:flutter_template_app/core/services/http_service.dart';
import 'package:flutter_template_app/data/models/post.dart';

class PostService {
  final _dio = HttpService().dio;

  Future<ListPostResponse> getListPost() async {
    try {
      final response = await _dio.get(
        '/social-media/api/services/app/UserPost/GetListPost',
        queryParameters: {"maxResultCount": 10},
      );

      // 1. Lấy đúng phần mảng dữ liệu từ JSON.
      // Dựa trên JSON bạn gửi, nó nằm ở response.data['data'] (hoặc response.data['result']['data'])
      final dynamic rawData = response.data;

      // 2. Sử dụng factory fromJson của ListPostResponse để parse toàn bộ
      return ListPostResponse.fromJson(rawData);
    } catch (error) {
      print('Error fetching posts: $error');
      // Trả về object rỗng để tránh crash app
      return ListPostResponse(data: [], success: false);
    }
  }
}
