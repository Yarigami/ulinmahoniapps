import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layout/mainlayout.dart';
import '../../../core/widgets/productcard.dart'; // Import ProductCard

class DetailHousePage extends StatelessWidget {
  const DetailHousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0, // Sesuaikan jika perlu
      showNavBar: false,
      showBottomNav: false, // Atau false, tergantung kebutuhan
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Gambar Utama
              Stack(
                children: [
                  Image.asset(
                    'assets/images/ulinhouse.jpg', // Ganti dengan path gambar yang sesuai
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        context.pop(); // Kembali ke halaman sebelumnya
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Bagian Informasi Properti
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ulin House West Jakarta', // Ganti dengan nama properti
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'House', // Ganti dengan jenis properti
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ulin House West Jakarta adalah kos mewah dan modern di Jelambar yang dirancang untuk anak muda dinamis. Mengusung konsep smart living, penghuni dapat mengontrol pencahayaan langsung dari gadget mereka. Tersedia dua tipe kamar yang nyaman dengan fasilitas eksklusif seperti gym, lounge, dan WiFi gratis, menciptakan keseimbangan antara produktivitas dan relaksasi dalam hunian yang stylish dan futuristik.', // Ganti dengan deskripsi properti
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.green),
                        SizedBox(width: 4),
                        Text('Jelambar, West Jakarta'), // Ganti dengan lokasi
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.green),
                        SizedBox(width: 4),
                        Text('8.4 (120 Reviews)'), // Ganti dengan rating
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            // Navigasi ke halaman komentar
                          },
                          child: Text('Lihat Komentar >'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFacilityIcon(Icons.tv, 'Lounge'),
                        _buildFacilityIcon(Icons.camera_alt, 'CCTV Area'),
                        _buildFacilityIcon(Icons.wifi, 'Free Wifi'),
                        _buildFacilityIcon(Icons.fitness_center, 'GYM'),
                      ],
                    ),
                  ],
                ),
              ),

              // Bagian Tipe Kamar
              Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room Type',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ProductCard(
                            image: 'assets/images/room1.jpg', // Ganti dengan path gambar yang sesuai
                            title: 'Alpha',
                            location: 'Ulin House West Jakarta',
                            detail: 'Kamar nyaman dengan desain modern',
                            price: 'Rp 200.000/malam',
                            onTap: () {
                              // Aksi ketika card diklik
                            },
                            width: 200,
                            height: 250,
                            imageHeight: 150,
                          ),
                          SizedBox(width: 16),
                          ProductCard(
                            image: 'assets/images/room2.jpg', // Ganti dengan path gambar yang sesuai
                            title: 'Beta',
                            location: 'Ulin House West Jakarta',
                            detail: 'Kamar luas dengan fasilitas lengkap',
                            price: 'Rp 250.000/malam',
                            onTap: () {
                              // Aksi ketika card diklik
                            },
                            width: 200,
                            height: 250,
                            imageHeight: 150,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk membuat ikon fasilitas
  Widget _buildFacilityIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.green),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
