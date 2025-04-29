import 'package:flutter/material.dart';

final Map<String, dynamic> roomData = {
  'name': 'Alpha Room',
  'location': 'Ulin House West Jakarta',
  'image': 'assets/images/ulinhouse.jpg',
  'checkIn': 'Sab, 15 Mar 2025 (14:00 - 16:00)',
  'checkOut': 'Mon, 17 Mar 2025 (12:00 - 13:00)',
};

// Data Item dan Harga dalam bentuk List
final List<Map<String, dynamic>> itemDetails = [
  {'name': 'Alpha Room', 'price': '510.754'},
  {'name': 'Beta Room', 'price': '620.500'},
  {'name': 'Gamma Room', 'price': '730.250'},
];

// Data Metode Pembayaran dalam bentuk List
final List<Map<String, dynamic>> paymentMethods = [
  {'icon': Icons.credit_card, 'text': 'Debit'},
  {'icon': Icons.credit_card, 'text': 'Kredit'},
];