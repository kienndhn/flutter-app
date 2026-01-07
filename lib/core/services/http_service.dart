import 'package:dio/dio.dart';

class HttpService {
  late final Dio dio;
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;

  HttpService._internal() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.yootek.com.vn'));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {},
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          bool success = await _handleRefreshToken();
          if (success) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
      },
    ));
  }
  Future<bool> _handleRefreshToken() async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final options =
        Options(method: requestOptions.method, headers: requestOptions.headers);
    return dio.request(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
