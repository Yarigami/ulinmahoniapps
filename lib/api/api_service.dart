import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'transaction_model.dart';

class ApiService{
  // API
  // final String apiUrl = 'https://demo-ulinmahoni.integrated-os.cloud/api/booking';
  //
  // Future <List<Transaction>> fetchTransactions() async{// fetchName
  //   final response = await http.get(Uri.parse(apiUrl));
  //
  //   if (response.statusCode == 200){
  //     final data = json.decode(response.body);
  //     final List<dynamic> transactionsJson = data['data'];
  //     return transactionsJson.map((json) => Transaction.fromJson(json)).toList();
  //   }
  //   else{
  //     throw Exception('Failed to load transaction');
  //   }
  // }

  // LOCAL
  Future<List<Transaction>> fetchTransactions() async{
    final response = await rootBundle.loadString('assets/response.json');
    final data = json.decode(response);
    final List<dynamic> transactionsJson = data['data'];
    return transactionsJson.map((json) => Transaction.fromJson(json)).toList();
  }
}
