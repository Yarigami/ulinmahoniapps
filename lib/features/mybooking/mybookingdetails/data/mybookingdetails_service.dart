import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_baseurl.dart';

class MyBookingDetailsService {
  final String baseUrl;

  MyBookingDetailsService({this.baseUrl = ApiConfig.baseUrl});

  Future<Map<String, dynamic>> getBookingDetailById(String idrec) async {
    final url = Uri.parse('$baseUrl/api/booking/detail/$idrec');

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']; // Sesuaikan dengan struktur API kamu
    } else {
      throw Exception('Failed to load booking detail: ${response.body}');
    }
  }
}
