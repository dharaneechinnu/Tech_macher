import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        print("Access Token  : ${response.data['access_token']}");
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

      return response;
    } catch (e) {
      print("❗ Dio exception during login request: $e");
      return null;
    }
  }
}
