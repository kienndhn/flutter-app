import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template_app/core/services/storage_service.dart';

import 'package:flutter_template_app/data/models/auth.dart';

class AuthService extends ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.yootek.com.vn"));
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isLoggedIn = false;
  String? _token;
  String? _userId;

  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;
  String? get userId => _userId;

  void setInitialStatus(bool status) {
    _isLoggedIn = status;
  }

  Future<bool> login(String userNameOrEmailAddress, String password) async {
    try {
      // Simulate API call
      final response = await _dio.post('/api/GlobalAuth/Authenticate', data: {
        "userNameOrEmailAddress": userNameOrEmailAddress,
        "password": password
      });

      if (response.statusCode == 200) {
        Auth authData = Auth.fromJson(response.data['result']);
        StorageService().saveToken(authData.accessToken);
        StorageService().saveRefreshToken(authData.refreshToken);
        _isLoggedIn = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      StorageService().clearAll();
      _isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }
}
