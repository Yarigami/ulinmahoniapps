import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_baseurl.dart';
import '../model/detailproperty_model.dart';
import 'package:flutter/foundation.dart'; // Import kDebugMode

class PropertyService {
  final String apiUrl = '${ApiConfig.baseUrl}/property'; // Sesuaikan dengan URL yang sesuai

  // Fungsi untuk mengambil detail properti berdasarkan ID
  Future<DetailPropertyModel> fetchDetailProperty(int propertyId) async {
    final url = Uri.parse('$apiUrl/$propertyId');
    print(url);
    print(propertyId);
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json', // Gunakan 'application/json' jika response dalam format JSON
        'Cache-Control': 'no-cache',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Mengembalikan model DetailPropertyModel dari JSON
        log("Fetch Detail Properties response (${response.statusCode}): ${response.body}");
        return DetailPropertyModel.fromJson(data);
      } else {
        if (kDebugMode) {
          print('Gagal ambil detail properti: ${response.statusCode}');
          print('Response body: ${response.body}'); // Print response body
        }
        throw Exception('Gagal ambil detail properti: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Terjadi kesalahan saat mengambil detail properti: $e');
        print('Stack trace: $stackTrace');
      }
      throw Exception('Terjadi kesalahan saat mengambil detail properti: $e');
    }
  }
}