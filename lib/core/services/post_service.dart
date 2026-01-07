import 'package:flutter_template_app/core/services/http_service.dart';
import 'package:flutter_template_app/data/models/post.dart';

class PostService {
  final _dio = HttpService().dio;

  Future<List<Post>> getListPost() async {
    try {
      print(_dio.options.baseUrl);
      print('interceptors = ${_dio.interceptors.length}');
      final response = await _dio.get(
          '/social-media/api/services/app/UserPost/GetListPost',
          queryParameters: {"maxResultCount": 10});
      List<Post> posts =
          response.data['result'].map((e) => Post.fromJson(e)).toList();
      return posts;
    } catch (error) {
      print('error: ${error}');

      return [];
    }
  }
}
