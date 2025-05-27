import 'package:dio/dio.dart';
import '../model/mybooking_model.dart';
import '../../../../core/constants/api_baseurl.dart';

class BookingService {
  final Dio dio;

  BookingService() : dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

  Future<List<MyBookingModel>> fetchBookingByUserId(int userId) async {
    final url = '/booking/userId/$userId';
    print('📡 Fetching from: ${ApiConfig.baseUrl}$url');

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
        // Ini akan menangani status code 2xx lainnya yang mungkin tidak diharapkan
        // atau jika server mengembalikan status non-200 tanpa DioException
        throw Exception('Failed to fetch booking data with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Tangani DioException secara spesifik
      if (e.response != null) {
        // Jika status code adalah 404
        if (e.response!.statusCode == 404) {
          // Asumsikan 404 berarti "Tidak ada booking ditemukan untuk user ini"
          print('Info: Tidak ada booking ditemukan untuk user ID $userId (status 404 dari server). Mengembalikan list kosong.');
          return []; // Mengembalikan list kosong daripada melempar error
        }
        // Untuk DioException lainnya dengan respons (misal: 400, 401, 500)
        print('Error fetching bookings (HTTP ${e.response!.statusCode}): ${e.response!.data}');
        throw Exception('Gagal mengambil data booking: Status ${e.response!.statusCode}');
      } else {
        // DioException tanpa respons (misal: error jaringan, timeout)
        print('Error jaringan atau Dio error tidak dikenal: ${e.message}');
        throw Exception('Error jaringan: ${e.message}');
      }
    } catch (e, stackTrace) {
      // Tangani error tak terduga lainnya yang bukan DioException
      print('Error tak terduga saat mengambil booking: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Terjadi error tak terduga saat mengambil data booking.');
    }
  }
}