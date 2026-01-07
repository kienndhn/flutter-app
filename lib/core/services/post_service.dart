import 'package:flutter_template_app/core/services/http_service.dart';
import 'package:flutter_template_app/data/models/post.dart';

class PostService {
  final _dio = HttpService().dio;

  Future<List<Post>> getListPost({int maxResultCount = 10}) async {
    try {
      final response = await _dio
          .get('', queryParameters: {"maxResultCount": maxResultCount});
      return [];
    } catch (error) {
      return [];
    }
  }
}
