import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../../../../../core/widgets/backbutton.dart';
import '../widgets/rooms.dart';

class DetailHousePage extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;

  const DetailHousePage({Key? key, required this.data}) : super(key: key);

  @override
  ConsumerState<DetailHousePage> createState() => _DetailHousePageState();
}

class _DetailHousePageState extends ConsumerState<DetailHousePage> {
  @override
  Widget build(BuildContext context) {
    final property = widget.data['data'];

    return MainLayout(
      currentIndex: 0,
      showNavBar: false,
      showBottomNav: false,
      showContactBar: true,
      pesansekarangbutton: false,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar + Header
              Stack(
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: property['image'] != null
                            ? MemoryImage(base64Decode(property['image']))
                            : const AssetImage('assets/images/ulinhouse.jpg') as ImageProvider,
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
                          property['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          property['tags'] ?? '',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Konten bawah
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
                        property['description'] ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Color(0xFF004D40)),
                          const SizedBox(width: 4),
                          Text(property['location'] ?? ''),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFF004D40)),
                          const SizedBox(width: 4),
                          const Text('4.8 (128 Reviews)'), // Rating dummy
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // Navigasi ke komentar
                            },
                            child: const Text(
                              'Lihat Komentar >',
                              style: TextStyle(color: Color(0xFF004D40)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          _buildFacilityIcon(Icons.wifi, 'WiFi'),
                          _buildFacilityIcon(Icons.security, '24/7 Security'),
                          _buildFacilityIcon(Icons.kitchen, 'Kitchen'),
                          _buildFacilityIcon(Icons.local_laundry_service, 'Laundry'),
                          _buildFacilityIcon(Icons.directions_car, 'Parking'),
                          _buildFacilityIcon(Icons.people, 'Common Area'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        RoomTypeSection(propertyData: {
          'id': property['idrec'], // ubah key jadi 'id'
          'name': property['name'],
          'description': property['description'],
          'location': property['location'],
        }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacilityIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF004D40)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF004D40))),
      ],
    );
  }
}
