import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_baseurl.dart';

class MyBookingDetailsService {
  final String baseUrl;

  MyBookingDetailsService({this.baseUrl = ApiConfig.baseUrl});

  // ✅ Fungsi POST upload gambar dalam bentuk Base64
  Future<bool> uploadImageAsBase64(String idrec, String base64Image) async {
    final url = Uri.parse('$baseUrl/api/booking/$idrec/upload');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'id': idrec,
          'image': base64Image,
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Upload success: ${response.body}");
        return true;
      } else {
        print("❌ Upload failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Error saat upload gambar: $e");
      return false;
    }
  }
}