import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_baseurl.dart';

class PaymentService {
  static Future<http.Response> postBooking({
    required Map<String, dynamic> bookingData,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/booking');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bookingData),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }
}
