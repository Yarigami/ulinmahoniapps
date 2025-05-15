import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ulinmahoniapps/features/home/model/properties_model.dart';
import '../../../core/constants/api_baseurl.dart';

class PropertiesApiService{
  // API
  final String propUrl = '${ApiConfig.baseUrl}/property';
  Future <List<Property>> fetchProperties() async{// fetchName
    final response = await http.get(Uri.parse(propUrl));

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      final List<dynamic> propertiesJson = data['data'];
      return propertiesJson.map((json) => Property.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load transaction');
    }
  }

// LOCAL
// Future<List<Property>> fetchProperties() async {
//   final response = await rootBundle.loadString('lib/api/properties.json');
//   final data = json.decode(response);
//   final List<dynamic> propertiesJson = data['data'];
//   return propertiesJson.map((json) => Property.fromJson(json)).toList();
// }
}