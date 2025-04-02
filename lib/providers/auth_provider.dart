import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _userRole;
  bool _isAuthenticated = false;

  String? get userRole => _userRole;
  bool get isAuthenticated => _isAuthenticated;

  // Login function
  Future<bool> login(String loginId, String password) async {
    if (loginId == "service123" && password == "1234") {
      _userRole = "service_worker";
      _isAuthenticated = true;
    } else if (loginId == "piping123" && password == "1234") {
      _userRole = "piping_worker";
      _isAuthenticated = true;
    } else {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userRole", _userRole!);
    await prefs.setBool("isAuthenticated", _isAuthenticated);

    notifyListeners();
    return true;
  }

  // Logout function
  Future<void> logout() async {
    _userRole = null;
    _isAuthenticated = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("userRole");
    await prefs.remove("isAuthenticated");

    notifyListeners();
  }

  // Restore session on app restart
  Future<void> loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userRole = prefs.getString("userRole");
    _isAuthenticated = prefs.getBool("isAuthenticated") ?? false;

    notifyListeners();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isAuthenticated") ?? false;
  }
}
