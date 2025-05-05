import 'package:flutter/material.dart';
import '../../../../core/layout/mainlayout.dart';
import '../../../../core/widgets/backbutton.dart';
import '../../data/detailhouse_data.dart';
import '../../presentation/widgets/roomtype.dart';

class DetailHousePage extends StatefulWidget {
  const DetailHousePage({Key? key}) : super(key: key);

  @override
  State<DetailHousePage> createState() => _DetailHousePageState();
}

class _DetailHousePageState extends State<DetailHousePage> {
  // Variabel State
  bool _isLoading = false;
  dynamic _propertyData = {}; // Inisialisasi dengan Map kosong
  String? _errorMessage;

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
      _propertyData = dummyPropertyData; // Gunakan data dummy
    } catch (error) {
      _errorMessage = 'Failed to load property details.';
    } finally {
      setState(() {
        _isLoading = false;
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
      pesansekarangbutton: false,
      child: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ulinhouse.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
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
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _propertyData['type'] ?? '',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Transform.translate(
                offset: Offset(0, -50),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tentang",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        _propertyData['description'] ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Color(0xFF004D40)),
                          SizedBox(width: 4),
                          Text(_propertyData['location'] ?? ''),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Color(0xFF004D40)),
                          SizedBox(width: 4),
                          Text('${_propertyData['rating']} (${_propertyData['reviews']} Reviews)'),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              // Navigasi ke halaman komentar
                            },
                            child: Text(
                              'Lihat Komentar >',
                              style: TextStyle(color: Color(0xFF004D40)),
                            ),
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
              ),
              RoomTypeSection(propertyData: _propertyData),
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
        Icon(icon, color: Color(0xFF004D40)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Color(0xFF004D40))),
      ],
    );
  }
}
