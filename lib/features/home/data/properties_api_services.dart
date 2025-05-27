import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_baseurl.dart';
import '../model/properties_model.dart';

class PropertyService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<List<PropertyModel>> fetchProperties() async {
    final url = Uri.parse('$baseUrl/property');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Cache-Control': 'no-cache',
        },
      );

      log("Fetch Properties response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        List<dynamic> dataList;

        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('data')) {
          dataList = jsonResponse['data'] as List<dynamic>;
        } else if (jsonResponse is List) {
          dataList = jsonResponse;
        } else {
          throw Exception('Unexpected API response format');
        }

        final properties = dataList
            .map((item) => PropertyModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return properties;
      } else {
        throw Exception('Failed to load properties: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching properties: $e');
    }
  }
}
