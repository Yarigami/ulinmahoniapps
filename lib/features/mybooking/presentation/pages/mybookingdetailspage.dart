import 'package:flutter/material.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/layout/mainlayout.dart';
import '../../data/mybooking_data.dart';
import 'package:intl/intl.dart';

class MyBookingDetail extends StatefulWidget {
  const MyBookingDetail({Key? key}) : super(key: key);

  @override
  State<MyBookingDetail> createState() => _MyBookingDetailState();
}

class _MyBookingDetailState extends State<MyBookingDetail> {
  Map<String, dynamic> bookingData = {};
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    try {
      // Find the booking with the matching ID (hardcoded for now)
      bookingData = bookings.firstWhere((booking) => booking['id'] == 1);
    } catch (e) {
      errorMessage = 'Booking not found';
      bookingData = {};
    }
    setState(() {}); // Trigger a rebuild to display the data
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 1,
      showNavBar: true,
      showBottomNav: true,
      child: SafeArea( // Mengganti Scaffold dengan SafeArea
        child: Column(
          children: [
            CustomAppBar(title: "My Booking Details"),
            Expanded(
              child: errorMessage != null
                  ? Center(
                child: Text(
                  'Error: $errorMessage',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
                  : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Image.asset(
                        bookingData['image'] ?? "assets/images/ulinhouse.jpg",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported, size: 40);
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                        children: [
                          const Center(child: Icon(Icons.apartment)),
                          _info("Nama:", bookingData['title'] ?? "Judul Tidak Tersedia"),
                          _info("Jenis Ruangan:", bookingData['location'] ?? "Lokasi Tidak Tersedia"),
                          _info("Check-In:", _formatDate(bookingData['checkIn']) ?? "Tanggal Check-In Tidak Tersedia"),
                          _info("Check-Out:", _formatDate(bookingData['checkOut']) ?? "Tanggal Check-Out Tidak Tersedia"),
                          const Divider(height: 20, color: Colors.black),
                          _info("Harga Per Malam:", _formatCurrency(bookingData['hargaPerMalam']) ?? "0"),
                          _info("Jumlah Malam:", bookingData['jumlahMalam'] ?? "0"),
                          _info("Harga Total:", _formatCurrency(bookingData['totalHarga']) ?? "0"),
                          _info("Diskon:", "${_formatCurrency(bookingData['hargaDiskon']) ?? "0"} (${_calculateDiscountPercentage(bookingData['totalHarga'], bookingData['hargaDiskon'])})"),
                          const Divider(height: 20, color: Colors.black),
                          _info("Harga Terakhir:", _formatCurrency(bookingData['totalHargaSetelahDiskon']) ?? "0", isBold: true, color: Color(0xFF005F21)), // Make "Harga Terakhir" bold and green
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Function to format the date
  String? _formatDate(String? dateString) {
    if (dateString == null) return null;

    try {
      // Parse the date string
      DateFormat inputFormat = DateFormat("EEE, dd/MM/yy (HH:mm - HH:mm)");
      DateTime dateTime = inputFormat.parse(dateString);

      // Format the date to the desired output format
      DateFormat outputFormat = DateFormat("EEE, dd MMM yyyy (HH:mm - HH:mm)");
      return outputFormat.format(dateTime);
    } catch (e) {
      print("Error formatting date: $e");
      return dateString; // Return the original string if formatting fails
    }
  }

// Function to format the currency
  String? _formatCurrency(dynamic amount) {
    if (amount == null) return null;

    // Format the currency to Indonesian Rupiah
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'RP. ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

// Function to calculate the discount percentage
  String _calculateDiscountPercentage(dynamic totalHarga, dynamic hargaDiskon) {
    if (totalHarga == null || hargaDiskon == null) return '0%';

    double discountPercentage = (hargaDiskon / totalHarga) * 100;
    return '${discountPercentage.toStringAsFixed(0)}%';
  }

  Widget _info(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black,
              fontSize: 16, // Adjust font size as needed
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black,
              fontSize: 16, // Adjust font size as needed
            ),
          ),
        ],
      ),
    );
  }
}
