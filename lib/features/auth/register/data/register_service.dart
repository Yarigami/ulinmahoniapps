import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/register_model.dart';
import '../../../../core/constants/api_baseurl.dart';

class RegisterService {

  Future<Register> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/register');
    http.Response response;

    try {
      response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );
    } catch (e) {
      throw Exception('Tidak dapat terhubung ke server: $e');
    }

    final statusCode = response.statusCode;
    final body = json.decode(response.body);

    switch (statusCode) {
      case 200:
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          return Register.fromJson(jsonData['data']);
        } else {
          throw Exception(jsonData['message'] ?? 'Gagal mendaftar');
        }
      case 201:
        if (body['status'] == 'success') {
          return Register.fromJson(body['data']);
        } else {
          throw Exception(body['message'] ?? 'Pendaftaran gagal');
        }
      case 400:
        throw Exception(body['message'] ?? 'Permintaan tidak valid (400)');

      case 401:
        throw Exception('Tidak diizinkan. Silakan login ulang (401)');

      case 403:
        throw Exception('Akses ditolak (403)');

      case 404:
        throw Exception('Endpoint tidak ditemukan (404)');

      case 422:
        final errors = body['errors'];
        if (errors != null && errors is Map) {
          final errorMessages = errors.values
              .map((e) => (e is List && e.isNotEmpty) ? e[0] : e.toString())
              .join(', ');
          throw Exception(errorMessages);
        }
        throw Exception(body['message'] ?? 'Data tidak valid (422)');

      case 500:
        throw Exception('Terjadi kesalahan server (500)');

      default:
        throw Exception('Terjadi kesalahan (${statusCode}): ${body['message'] ?? 'Tidak diketahui'}');
    }
  }
}
