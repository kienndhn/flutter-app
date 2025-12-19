import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isLoggedIn = false;
  String? _token;
  String? _userId;

  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;
  String? get userId => _userId;

  AuthService() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      _token = await _storage.read(key: 'auth_token');
      _userId = await _storage.read(key: 'user_id');
      _isLoggedIn = _token != null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error checking login status: $e');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, accept any non-empty credentials
      if (email.isNotEmpty && password.isNotEmpty) {
        _token = 'demo_token_${DateTime.now().millisecondsSinceEpoch}';
        _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
        _isLoggedIn = true;
        
        await _storage.write(key: 'auth_token', value: _token);
        await _storage.write(key: 'user_id', value: _userId);
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _storage.delete(key: 'auth_token');
      await _storage.delete(key: 'user_id');
      
      _token = null;
      _userId = null;
      _isLoggedIn = false;
      
      notifyListeners();
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }
}
