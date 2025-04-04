import 'dart:convert';
import 'package:app2/core/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AuthProvider with ChangeNotifier {
  String? _userRole;
  bool _isAuthenticated = false;

  String? get userRole => _userRole;
  bool get isAuthenticated => _isAuthenticated;

  final NetworkService _networkService = NetworkService();
  final Box authBox = Hive.box('authBox');

  Future<bool> login(String loginId, String password) async {
    try {
      print("🔐 Attempting login with:");
      print("Username: $loginId");
      print("Password: $password");

      final Response? response = await _networkService.loginServiceman(
        username: loginId,
        password: password,
        servicemanType: "Serviceman",
      );

      if (response == null) {
        print("❌ No response received from the server.");
        return false;
      }

      print("✅ Status Code: ${response.statusCode}");
      print("✅ Response Data: ${response.data}");

      if (response.statusCode == 200) {
        // Assign user role
        if (loginId.toLowerCase().contains("piping")) {
          _userRole = "piping_worker";
        } else {
          _userRole = "service_worker";
        }

        _isAuthenticated = true;

        // Save session to Hive
        authBox.put("userRole", _userRole!);
        authBox.put("isAuthenticated", _isAuthenticated);
        authBox.put("authToken", response.data['token'] ?? "");
        authBox.put("loginTimestamp", DateTime.now().millisecondsSinceEpoch);

        // 🔽 Parse nested JSON and store serviceman name/code
        final responseData = response.data;
        final String jsonString = responseData['value'];
        final Map<String, dynamic> parsedJson = jsonDecode(jsonString);

        final serviceman = parsedJson['results']?['serviceman'];
        if (serviceman != null) {
          final servicemanName = serviceman['servicename_name'] ?? 'Unknown';
          final servicemanCode = serviceman['servicename_code'] ?? 'N/A';

          print("🧑‍🔧 Serviceman Name: $servicemanName");
          print("🆔 Serviceman Code: $servicemanCode");

          final userBox = Hive.box('userBox');
          userBox.put('servicemanName', servicemanName);
          userBox.put('servicemanCode', servicemanCode);
        } else {
          print("⚠️ Serviceman details not found in parsed response.");
        }

        notifyListeners();
        return true;
      } else {
        print("❌ Login failed: ${response.statusCode} - ${response.data}");
        return false;
      }
    } catch (e) {
      print("❗ Exception occurred during login: $e");
      return false;
    }
  }

  Future<void> logout() async {
    _userRole = null;
    _isAuthenticated = false;

    await authBox.clear();
    final userBox = Hive.box('userBox');
    await userBox.clear();

    notifyListeners();
  }

  Future<void> loadUserSession() async {
    final int? timestamp = authBox.get("loginTimestamp");
    final int now = DateTime.now().millisecondsSinceEpoch;

    if (timestamp != null && (now - timestamp) < 3600000) {
      _userRole = authBox.get("userRole");
      _isAuthenticated = authBox.get("isAuthenticated") ?? false;
      notifyListeners();
    } else {
      print("🔁 Session expired. Logging out.");
      await logout();
    }
  }

  Future<bool> isLoggedIn() async {
    final int? timestamp = authBox.get("loginTimestamp");
    final int now = DateTime.now().millisecondsSinceEpoch;

    if (timestamp != null && (now - timestamp) < 3600000) {
      return authBox.get("isAuthenticated") ?? false;
    } else {
      await logout();
      return false;
    }
  }
}
