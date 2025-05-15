import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_baseurl.dart';
import '../model/detailproperty_model.dart';

class PropertyService {
  // Base URL API
  final String apiUrl = '${ApiConfig.baseUrl}l/property'; // Sesuaikan dengan URL yang sesuai

  // Fungsi untuk mengambil detail properti berdasarkan ID
  Future<DetailPropertyModel> fetchDetailProperty(int propertyId) async {
    final url = Uri.parse('$apiUrl/1');
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
        return DetailPropertyModel.fromJson(data);
      } else {
        throw Exception('Gagal ambil detail properti: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil detail properti: $e');
    }
  }
}
