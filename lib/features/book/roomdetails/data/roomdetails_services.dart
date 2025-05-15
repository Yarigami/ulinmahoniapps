// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../../core/constants/api_baseurl.dart';
// import '../model/roomdetails_model.dart';
//
// class RoomService {
//   // Fungsi untuk mengambil daftar kamar berdasarkan ID properti (idrec)
//   Future<List<RoomDetailsModel>> getRoomsByIdRec(String idrec) async {
//     final url = Uri.parse('${ApiConfig.baseUrl}/rooms/$idrec');
//     print('Request URL: $url');
//     print('🔍 Mengambil data kamar berdasarkan idrec: $idrec');
//
//     try {
//       final response = await http.get(url, headers: {
//         'Accept': 'application/json',
//         'Cache-Control': 'no-cache',
//       });
//
//       if (response.statusCode == 200) {
//         final List data = jsonDecode(response.body);
//         return data.map((e) => RoomDetailsModel.fromJson(e)).toList();
//       } else {
//         throw Exception('Gagal ambil data kamar: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Terjadi kesalahan saat mengambil data kamar: $e');
//     }
//   }
// }
