import 'package:flutter/material.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/layout/mainlayout.dart';
import 'package:intl/intl.dart';

class MyBookingDetail extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  const MyBookingDetail({Key? key, required this.bookingData}) : super(key: key);

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
      // Cek jika bookingData kosong atau null
      if (widget.bookingData.isEmpty) {
        errorMessage = 'Booking data tidak ditemukan';
        bookingData = {};
      } else {
        bookingData = widget.bookingData;
      }
    } catch (e) {
      errorMessage = 'Terjadi kesalahan saat mengambil data: $e';
      bookingData = {};
    }
    setState(() {}); // Trigger a rebuild to display the data
  }


  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 1,
      showNavBar: false,
      showBottomNav: false,
      child: SafeArea(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          _info("Harga Terakhir:", _formatCurrency(bookingData['totalHargaSetelahDiskon']) ?? "0", isBold: true, color: Color(0xFF005F21)),
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

  String? _formatDate(String? dateString) {
    if (dateString == null) return null;

    try {
      DateFormat inputFormat = DateFormat("EEE, dd/MM/yy (HH:mm - HH:mm)");
      DateTime dateTime = inputFormat.parse(dateString);
      DateFormat outputFormat = DateFormat("EEE, dd MMM yyyy (HH:mm - HH:mm)");
      return outputFormat.format(dateTime);
    } catch (e) {
      print("Error formatting date: $e");
      return dateString;
    }
  }

  String? _formatCurrency(dynamic amount) {
    if (amount == null) return null;
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'RP. ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

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
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

