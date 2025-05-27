import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../../../../../core/widgets/backbutton.dart';
import '../widgets/rooms.dart';
import '../../model/detailproperty_model.dart';
import '../../provider/detailproperty_provider.dart';

class DetailHousePage extends ConsumerWidget {
  final int id;

  const DetailHousePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailProperty = ref.watch(detailPropertyProvider(id));

    return MainLayout(
      currentIndex: 0,
      showNavBar: false,
      showBottomNav: false,
      showContactBar: true,
      pesansekarangbutton: false,
      child: SafeArea(
        child: detailProperty.when(
          data: (property) {
            return _buildDetailHouseContent(context, property);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text('Error: ${error.toString()}'),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailHouseContent(BuildContext context, DetailPropertyModel property) {
    print("====FetchDataDetailProperty");
    print('ID : ${property.id}');
    return SingleChildScrollView(
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
                    image: (property.image != null)
                        ? (property.image!.startsWith('data:image') ||
                        property.image!.length > 100
                        ? MemoryImage(base64Decode(
                        property.image!.split(',').last))
                    as ImageProvider
                        : AssetImage(property.image!)
                    as ImageProvider)
                        : const AssetImage('assets/images/ulinhouse.jpg'),
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
                      property.name?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      property.tags ?? '',
                      style: const TextStyle(
                          fontSize: 16, color: Colors.white),
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
                    property.description ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Color(0xFF004D40)),
                      const SizedBox(width: 4),
                      Text(property.location ?? ''),
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
                ],
              ),
            ),
          ),

          // Room Section
          RoomTypeSection(
            propertyData: property, // Kirim DetailPropertyModel langsung
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF004D40)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF004D40))),
      ],
    );
  }
}

  // Catatan: fungsi _buildRoomFacilities() belum digunakan di build()
  // Jika ingin digunakan, pastikan widget.property.attributes?.amenities != null
  // Widget _buildRoomFacilities() {
  //   final List<Map<String, String>> facilityMapping = [
  //     {'label': 'AC', 'key': 'Air Conditioning'},
  //     {'label': 'Bathroom', 'key': 'Private Bathroom'},
  //     {'label': 'Furnished', 'key': 'Furnished'},
  //     {'label': 'TV', 'key': 'TV Cable Ready'},
  //   ];
  //
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: facilityMapping.map((facility) {
  //       final isAvailable = roomAmenities.contains(facility['key']);
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             isAvailable ? Icons.check_circle : Icons.cancel,
  //             color: isAvailable ? Colors.green : Colors.red,
  //           ),
  //           const SizedBox(height: 4),
  //           Text(
  //             facility['label'] ?? '',
  //             style: const TextStyle(fontSize: 12),
  //           ),
  //         ],
  //       );
  //     }).toList(),
  //   );
