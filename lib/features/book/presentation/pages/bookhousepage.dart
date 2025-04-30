import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../../../../../core/widgets/backbutton.dart';
import '../../data/bookhouse_data.dart';

class BookHousePage extends StatefulWidget {
  const BookHousePage({Key? key}) : super(key: key);

  @override
  State<BookHousePage> createState() => _BookHousePageState();
}

class _BookHousePageState extends State<BookHousePage> {
  // Variabel State
  bool _isLoading = false;
  dynamic _propertyData = {}; // Inisialisasi dengan Map kosong
  String? _errorMessage;

  // Controller untuk TextField tanggal
  TextEditingController _checkInDateController = TextEditingController();
  TextEditingController _checkOutDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPropertyDetails();
  }

  // Metode untuk memuat data dari API (atau data dummy)
  Future<void> _loadPropertyDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // TODO: Ganti dengan kode untuk memanggil API Anda
      await Future.delayed(Duration(seconds: 1)); // Simulasi loading API
      _propertyData = propertyData; // Gunakan data dummy dari bookhouse_data.dart
    } catch (error) {
      _errorMessage = 'Failed to load property details.';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime.now();

    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (_picked != null) {
      String dateFormat = DateFormat('dd-MM-yyyy').format(_picked);
      setState(() {
        controller.text = dateFormat;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      showNavBar: false,
      showBottomNav: false,
      showContactBar: true,
      child: SafeArea(
        child: Container(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stack untuk Gambar Utama dan Back Button
                Stack(
                  children: [
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
                    const Positioned(
                      top: 16,
                      left: 16,
                      child: CustomBackButton(),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _propertyData['name'] ?? 'Loading...',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _propertyData['type'] ?? '',
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Informasi Properti (Card)
                Transform.translate(
                  offset: const Offset(0, -50),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
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
                        const Text(
                          "Tentang",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          _propertyData['description'] ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Color(0xFF004D40)),
                            const SizedBox(width: 4),
                            Text(_propertyData['location'] ?? ''),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFF004D40)),
                            const SizedBox(width: 4),
                            Text('${_propertyData['rating']} (${_propertyData['reviews']} Reviews)'),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // Navigasi ke halaman komentar
                              },
                              child: const Text('Lihat Komentar >', style: TextStyle(color: Color(0xFF004D40))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildFacilityIcon(Icons.tv, 'Lounge'),
                            _buildFacilityIcon(Icons.camera_alt, 'CCTV Area'),
                            _buildFacilityIcon(Icons.wifi, 'Free Wifi'),
                            _buildFacilityIcon(Icons.fitness_center, 'GYM'),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Date Fields
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                          child: InkWell(
                            onTap: () {
                              _selectDate(_checkInDateController);
                            },
                            child: _buildDateInput('Check In', _checkInDateController),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                          child: InkWell(
                            onTap: () {
                              _selectDate(_checkOutDateController);
                            },
                            child: _buildDateInput('Check Out', _checkOutDateController),
                          ),
                        ),

                        const SizedBox(height: 16),
                        const Text(
                          'Room Facility',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        _buildRoomFacilitySection(),

                        const SizedBox(height: 16),
                        const Text(
                          'Price',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        _buildPriceSection(context, _propertyData['prices']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            controller.text.isEmpty ? label : controller.text,
            style: const TextStyle(fontSize: 16),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  // Widget untuk menampilkan bagian Room Facility
  Widget _buildRoomFacilitySection() {
    return Row(
      children: [
        Expanded(
          child: _buildRoomFacilityContent('assets/images/ulinhouse.jpg', 'Bedroom'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildRoomFacilityContent('assets/images/ulinhouse.jpg', 'Inside Bathroom'),
        ),
      ],
    );
  }

  // Widget untuk menampilkan bagian Price
  Widget _buildPriceSection(BuildContext context, List<Map<String, String>> prices) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // agar tinggi ikut maksimal
        children: prices.map((price) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () {
                  context.push('/payment');
                },
                child: _buildPriceContent(
                  price['label'] ?? '',
                  'assets/images/ulinhouse.jpg',
                  price['price'] ?? '',
                  discount: price['discount'],
                  context: context,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }


  // Widget pembantu untuk membuat ikon fasilitas
  Widget _buildFacilityIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Color(0xFF004D40)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Color(0xFF004D40))),
      ],
    );
  }

  Widget _buildRoomFacilityContent(String image, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align keseluruhan konten ke kiri
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            image,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left, // Pastikan teks rata kiri
          ),
        ),
      ],
    );
  }

// Widget pembantu untuk membuat konten harga (tanpa card)
  Widget _buildPriceContent(String label, String image, String price, {String? discount, required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align keseluruhan konten ke kiri
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                image,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            if (discount != null)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF005F21),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    discount,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align teks dan subteks ke kiri
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                price,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  void dispose() {
    _checkInDateController.dispose();
    _checkOutDateController.dispose();
    super.dispose();
  }
}


