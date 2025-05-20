import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/rooms_model.dart';
import '../../../../core/constants/api_baseurl.dart'; // Misalnya di sini ada BASE_URL

class RoomService {
  Future<List<RoomModel>> getRoomsByPropertyId(int propertyId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/rooms?property_id=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => RoomModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }
}
