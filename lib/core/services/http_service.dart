import 'package:dio/dio.dart';
import 'package:flutter_template_app/core/services/storage_service.dart';

class HttpService {
  late final Dio dio;
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;

  HttpService._internal() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.yootek.com.vn'));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await StorageService().getToken();
        print(token);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            bool success = await _handleRefreshToken();
            if (success) {
              return handler.resolve(await _retry(error.requestOptions));
            } else {
              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  error: "Refresh token expired",
                  type: DioExceptionType.badResponse,
                ),
              );
            }
          } catch (e) {
            return handler.next(error);
          }
        }
        return handler.next(error);
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
