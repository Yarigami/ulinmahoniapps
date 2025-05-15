import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/mybooking_model.dart';

class BookingService {
  static const String baseUrl = 'http://demo-ulinmahoni.integrated-os.cloud/api';
  final Dio dio;

  BookingService() : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<MyBookingModel>> fetchBookingByUserId(int userId) async {
    final url = '/booking/userId/$userId';
    print('📡 Fetching from: $baseUrl$url');

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('📦 Status Code: ${response.statusCode}');
      print('📦 Body: ${response.data}');

      if (response.statusCode == 200) {
        final body = response.data;

        // Periksa apakah data yang diterima merupakan Map dengan key 'data'
        if (body is Map && body['status'] == 'success' && body['data'] is List) {
          List data = body['data'];
          return data.map((json) => MyBookingModel.fromJson(json)).toList();
        } else {
          print('Unexpected format: ${body}');
          throw Exception('Unexpected API response format.');
        }
      } else {
        throw Exception('Failed to fetch booking data');
      }
    } catch (e, stackTrace) {
      print('Error fetching bookings: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to fetch booking data');
    }
  }

}
