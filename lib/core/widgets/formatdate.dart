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