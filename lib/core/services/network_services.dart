import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NetworkService {
  final Dio dio = Dio();

  final String clientId = dotenv.env['CLIENT_ID']!;
  final String clientSecret = dotenv.env['CLIENT_SECRET']!;
  final String tenantId = dotenv.env['TENANT_ID']!;
  final String scope = dotenv.env['SCOPE']!;
  String get tokenUrl =>
      'https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token';

  Future<String?> getAccessToken() async {
    try {
      final response = await dio.post(
        tokenUrl,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'grant_type': 'client_credentials',
          'scope': scope,
        },
      );

      if (response.statusCode == 200) {
        print("✅ Access Token: ${response.data['access_token']}");
        return response.data['access_token'];
      } else {
        print(
          "❌ Failed to fetch token: ${response.statusCode} ${response.data}",
        );
        return null;
      }
    } catch (e) {
      print("❗ Dio exception: $e");
      return null;
    }
  }

  Future<Response?> loginServiceman({
    required String username,
    required String password,
    required String servicemanType,
  }) async {
    print("🔐 Attempting login...");
    print("👤 Username: $username");
    print("🔑 Password: $password");
    print("🛠️ Service Type: $servicemanType");

    final accessToken = await getAccessToken();

    if (accessToken == null) {
      print("❌ Cannot proceed without token");
      return null;
    }

    final String loginUrl =
        'https://api.businesscentral.dynamics.com/v2.0/$tenantId/SandboxDev/ODataV4/ServiceApp_ServiceAuth?company=SEMBAS';

    final nestedJson = jsonEncode({
      "servicelogin": {
        "username": username,
        "password": password,
        "serviceman_type": servicemanType,
      },
    });

    final requestBody = {"servicelogin": nestedJson};

    try {
      final response = await dio.post(
        loginUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
        data: jsonEncode(requestBody),
      );

      print("📦 Login API Response (${response.statusCode}):");
      print(response.data);

      return response;
    } catch (e) {
      print("❗ Dio exception during login request: $e");
      return null;
    }
  }

  Future<Response?> getServicemanData({
    required String username,
    required String servicemanType,
  }) async {
    final accessToken = await getAccessToken();

    if (accessToken == null) {
      print("❌ Cannot proceed without token");
      return null;
    }

    final String url =
        'https://api.businesscentral.dynamics.com/v2.0/$tenantId/SandboxDev/ODataV4/ServiceApp_GetServiceLogin?company=SEMBAS';

    final requestBody = {
      "servicelogin": jsonEncode({
        "servicelogin": {
          "username": username,
          "serviceman_type": servicemanType,
        },
      }),
    };

    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
        data: jsonEncode(requestBody),
      );

      print("📦 GetServicemanData API Response (${response.statusCode}):");
      print(response.data);

      return response;
    } catch (e) {
      print("❗ Dio exception during serviceman data request: $e");
      return null;
    }
  }

  Future<Response?> getServiceOrders() async {
    final accessToken = await getAccessToken();
    final servicemanCode = Hive.box('userBox').get('servicemanCode') ?? "";

    if (accessToken == null) {
      print("❌ Missing access token");
      return null;
    }

    if (servicemanCode.isEmpty) {
      print("❌ Missing servicemanCode");
      return null;
    }

    final url =
        'https://api.businesscentral.dynamics.com/v2.0/3c6a50d8-d57d-4dc3-91cc-47759a72545e/SandboxDev/ODataV4/ServiceApp_GetServiceLogin?company=SEMBAS';

    final requestBody = {
      "servicelogin": jsonEncode({
        "servicelogin": {
          "username": servicemanCode,
          "serviceman_type": "Serviceman",
        },
      }),
    };

    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
        data: jsonEncode(requestBody),
      );

      print("📦 Service Orders Response (${response.statusCode}):");
      print(response.data);

      return response;
    } catch (e) {
      print("❗ Dio exception while fetching service orders: $e");
      return null;
    }
  }
}
