import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? formatDate(String? dateString) {
  if (dateString == null) return null;
  try {
    // Menggunakan format ISO 8601 untuk parsing
    DateTime dateTime = DateTime.parse(dateString);

    // Format output sesuai dengan format yang diinginkan
    DateFormat outputFormat = DateFormat("EEE, dd MMM yyyy HH:mm");
    return outputFormat.format(dateTime);
  } catch (e) {
    print("Error formatting date: $e");
    return dateString;
  }
}

String? formatCurrency(dynamic amount) {
  if (amount == null) return null;
  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
  return formatCurrency.format(amount);
}

Widget info(String label, String value, {bool isBold = false, Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
            color: color ?? Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget sectionTitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}