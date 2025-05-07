import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class AuthService {
  static const String baseUrl = 'http://demo-ulinmahoni.integrated-os.cloud';
  final Dio dio;
  final CookieJar cookieJar;

  AuthService()
      : dio = Dio(BaseOptions(baseUrl: baseUrl)),
        cookieJar = CookieJar() {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/api/login',
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      // Tambahkan pemeriksaan null di sini
      if (response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          dynamic data = response.data;

          // Coba decode jika masih string
          if (data is String) {
            try {
              data = jsonDecode(data);
            } catch (e) {
              print('Error decoding JSON: $e');
              return null; // Mengembalikan null jika gagal decode
            }
          }

          // Periksa struktur respons API
          if (data is Map && data['status'] == 'success' && data['data'] is Map && data['data']['token'] != null) {
            final token = data['data']['token'];
            final user = data['data']['user'] as Map<String, dynamic>?;  // Ambil informasi pengguna
            await _saveTokenToCookies(token);

            // Mengembalikan Map berisi token dan email
            return {'token': token, 'email': user?['email'] ?? 'N/A'};
          } else {
            print('Invalid response structure: $data');
            return null; // Mengembalikan null jika struktur respons tidak valid
          }
        } else {
          print('Login failed with status code: ${response.statusCode}, data: ${response.data}');
          return null; // Mengembalikan null jika status code tidak valid
        }
      } else {
        return null; // Mengembalikan null jika status code null
      }
    } catch (e, stackTrace) {
      print('Network error: $e, stackTrace: $stackTrace');
      return null; // Mengembalikan null jika terjadi kesalahan jaringan
    }
  }


  Future<void> _saveTokenToCookies(String token) async {
    try {
      final uri = Uri.parse('$baseUrl/api/login'); // KEMBALIKAN KE ASLI
      final cookie = Cookie('auth_token', token)
        ..domain = uri.host
        ..path = '/'; // Hapus ..httpOnly = true jika ingin diakses dari JavaScript

      await cookieJar.saveFromResponse(uri, [cookie]);
    } catch (e) {
      print('Error saving cookie: $e');
    }
  }

  Future<String?> getTokenFromCookies() async {
    try {
      final uri = Uri.parse('$baseUrl/api/login'); //Perbaiki URI
      final cookies = await cookieJar.loadForRequest(uri);
      final tokenCookie = cookies.firstWhere(
            (cookie) => cookie.name == 'auth_token',
        orElse: () => Cookie('auth_token', ''),
      );
      return tokenCookie.value.isNotEmpty ? tokenCookie.value : null;
    } catch (e) {
      print('Error getting token from cookies: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final uri = Uri.parse('$baseUrl/api/login');  //Perbaiki URI
      await cookieJar.delete(uri); // Hapus cookie saat logout
    } catch (e) {
      print('Error deleting cookies: $e');
    }
  }
}
