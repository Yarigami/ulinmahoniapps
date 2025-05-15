import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_baseurl.dart';
import '../model/rooms_model.dart';

class RoomService {
  // Fungsi untuk mengambil daftar kamar berdasarkan ID properti
  Future<List<RoomModel>> getRoomsByPropertyId(int propertyId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/rooms/propertyId/$propertyId');
    print(propertyId);
    print(url);
    print('✅✅✅✅✅✅');

    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Cache-Control': 'no-cache',
      });

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => RoomModel.fromJson(e)).toList();
      } else {
        throw Exception('Gagal ambil data kamar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil data kamar: $e');
    }
  }
}
