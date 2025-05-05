import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../../../../../core/widgets/backbutton.dart';
import '../../data/bookhouse_data.dart';
import '../widgets/roomfacility_section.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter untuk navigasi

class BookHousePage extends StatefulWidget {
  const BookHousePage({Key? key}) : super(key: key);

  @override
  State<BookHousePage> createState() => _BookHousePageState();
}

class _BookHousePageState extends State<BookHousePage> {
  // Variabel State
  bool _isLoading = false;
  dynamic _propertyData = {};
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
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime(2030);

    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF004D40), // Warna tombol OK dan header
              onPrimary: Colors.white,     // Warna teks di header
              onSurface: Colors.black,     // Warna teks di body
            ),
            dialogBackgroundColor: Colors.white, // Background putih
          ),
          child: child!,
        );
      },
    );
    if (_picked != null) {
      String dateFormat = DateFormat('dd-MM-yyyy').format(_picked);
      setState(() {
        controller.text = dateFormat;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      showNavBar: false,
      showBottomNav: false,
      showContactBar: true,
      pesansekarangbutton: true,
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
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                _propertyData['prices'][1]['price'],
                                style: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _propertyData['prices'][0]['price'],
                                style: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ],
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
                        Center(
                          child: buildRoomFacilitySection(),
                        ),
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

  @override
  void dispose() {
    _checkInDateController.dispose();
    _checkOutDateController.dispose();
    super.dispose();
  }
}
