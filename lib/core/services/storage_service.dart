import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  // Đối tượng dùng để thao tác với bộ nhớ bảo mật
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // --- Các hàm tiện ích ---

  // Lưu Access Token
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  // Lấy Access Token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  // Lưu Refresh Token
  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: 'refresh_token', value: token);
  }

  // Xóa toàn bộ dữ liệu (dùng khi Logout)
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
