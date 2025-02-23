import 'package:bipbip/main.dart';
import 'package:flutter/foundation.dart';
import '../models/auth_response.dart';

class UserModel extends ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;
  Map<String, dynamic>? _userData;

  bool get isAuthenticated => _accessToken != null;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  Map<String, dynamic>? get userData => _userData;

  void initializeFromAuth(AuthResponse? authData) {
    if (authData != null) {
      _accessToken = authData.access;
      _refreshToken = authData.refresh;
      _userData = authData.user.toJson();
      notifyListeners();
    }
  }

  Future<void> setSession(AuthResponse authData) async {
    _accessToken = authData.access;
    _refreshToken = authData.refresh;
    _userData = authData.user.toJson();
    await sessionManager.saveSession(authData);
    notifyListeners();
  }

  Future<void> logout() async {
    _accessToken = null;
    _refreshToken = null;
    _userData = null;
    await sessionManager.clearSession();
    notifyListeners();
  }
}