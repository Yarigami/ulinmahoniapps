import 'package:flutter/material.dart';
import '../../../../../core/widgets/appbar.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../widgets/widgets.dart';
import '../../data/mybookingdetails_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class MyBookingDetail extends StatefulWidget {
  final Map<String, dynamic> bookingData;

  const MyBookingDetail({Key? key, required this.bookingData}) : super(key: key);

  @override
  State<MyBookingDetail> createState() => _MyBookingDetailState();
}

class _MyBookingDetailState extends State<MyBookingDetail> {
  Map<String, dynamic> bookingData = {};
  String? errorMessage;
  File? _selectedImage; // Simpan file gambar yang dipilih
  String? _base64Image; // Simpan gambar dalam format Base64

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

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      final file = File(pickedFile.path);
      setState(() {
        _selectedImage = file;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Gagal memilih gambar: $e")),
      );
      print('Error Memilih Gambar: $e');
    }
  }

  // Fungsi untuk mengunggah gambar
  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ℹ️ Pilih gambar terlebih dahulu")),
      );
      return;
    }

    try {
      // Konversi gambar ke Base64
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      final service = MyBookingDetailsService();
      final success = await service.uploadImageAsBase64(widget.bookingData['id'].toString(), base64Image);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Gambar berhasil diupload")),
        );
        print('✅ Berhasil diupload');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Gagal upload gambar")),
        );
        print('❌ Gagal upload gambar');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Gagal upload gambar: $e")),
      );
      print('❌ Error Upload Gambar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingType = bookingData['booking_type'] ?? 'daily'; // default daily

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
                          sectionTitle('Detail Pemesanan'),
                          info("Id Pemesanan:", bookingData['order_id'] ?? "-"),
                          info("Kode Transaksi:", bookingData['transaction_code'] ?? "-"),
                          info("Nomor Telepon", bookingData['user_phone_number'] ?? "-"),
                          info("Tipe Pemesanan", bookingData['booking_type'] ?? "-"),
                          const Divider(height: 30),
                          sectionTitle("Detail Waktu"),
                          info("Daftar Masuk:", formatDate(bookingData['check_in']) ?? "-"),
                          info("Daftar Keluar:", formatDate(bookingData['check_out']) ?? "-"),
                          const Divider(height: 30),
                          sectionTitle("Harga Booking"),
                          info(
                              "Harga : ",bookingData['room_price'].toString() ?? '-',
                          ),
                          info(
                            bookingType == 'daily'
                                ? "Jumlah Malam:"
                                : "Jumlah Bulan:",
                            bookingData['booking_days']?.toString() ?? "0",
                          ),
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

                  // Tampilkan gambar yang dipilih
                  if (_selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.file(
                        _selectedImage!,
                        height: 150,
                      ),
                    ),

                  // Tombol untuk memilih gambar
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                      child: ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text("Pilih Gambar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF005F21),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Tombol untuk mengunggah gambar
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                      child: ElevatedButton.icon(
                        onPressed: _selectedImage != null ? _uploadImage : null,
                        icon: const Icon(Icons.upload),
                        label: const Text("Upload Gambar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF005F21),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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