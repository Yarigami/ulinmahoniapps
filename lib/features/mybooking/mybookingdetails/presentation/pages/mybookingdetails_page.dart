import 'package:flutter/material.dart';
import '../../../../../core/widgets/appbar.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../widgets/widgets.dart';

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
      if (widget.bookingData.isEmpty) {
        errorMessage = 'Booking data tidak ditemukan';
        bookingData = {};
      } else {
        bookingData = widget.bookingData;
        print(widget.bookingData);
      }
    } catch (e) {
      errorMessage = 'Terjadi kesalahan saat mengambil data: $e';
      bookingData = {};
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 1,
      showNavBar: false,
      showBottomNav: false,
      child: Stack(
        children: [
          // Konten utama scrollable
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stack untuk gambar & teks
                  Stack(
                    children: [
                      // Gambar background
                      Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/ulinhouse.jpg'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      // Nama properti dan kamar
                      Positioned(
                        bottom: 60,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookingData['property_name'] ?? "Nama Kos",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bookingData['room_name'] ?? "Nama Kamar",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Card putih naik ke atas
                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sectionTitle('Detail Order'),
                          info("Order Id:", bookingData['order_id']),
                          info("Transaction Code:", bookingData['transaction_code']),
                          const Divider(height: 30),
                          sectionTitle("Detail Waktu"),
                          info("Check-In:", formatDate(bookingData['check_in']) ?? "-"),
                          info("Check-Out:", formatDate(bookingData['check_out']) ?? "-"),
                          const Divider(height: 30),
                          sectionTitle("Harga Booking"),
                          info("Harga Per Malam:", formatCurrency(bookingData['daily_price']) ?? "0"),
                          info("Jumlah Malam:", bookingData['booking_days']?.toString() ?? "0"),
                          info("Pajak:", formatCurrency(bookingData['admin_fees']) ?? "0"),
                          const Divider(height: 30),
                          info(
                            "Harga Total:",
                            formatCurrency(bookingData['grandtotal_price']) ?? "0",
                            isBold: true,
                            color: const Color(0xFF005F21),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Fixed AppBar di atas semua
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomAppBar(title: "My Booking Details"),
          ),
        ],
      ),
    );
  }
}
