import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../../../../../core/widgets/backbutton.dart';
import '../widgets/rooms.dart';
import '../../model/detailproperty_model.dart';

class DetailHousePage extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;

  const DetailHousePage({Key? key, required this.data}) : super(key: key);

  @override
  ConsumerState<DetailHousePage> createState() => _DetailHousePageState();
}


class _DetailHousePageState extends ConsumerState<DetailHousePage> {
  @override
  void initState() {
    super.initState();
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
                        image: (widget.data != null && widget.data['image'] != null)
                            ? (widget.data['image'].startsWith('data:image') || widget.data['image'].length > 100
                            ? MemoryImage(base64Decode(
                            widget.data['image'].split(',').last)) as ImageProvider
                            : AssetImage(widget.data['image']) as ImageProvider)
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
                          widget.data['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.data['tags'] ?? '',
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
                        widget.data['description'] ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Color(0xFF004D40)),
                          const SizedBox(width: 4),
                          Text(widget.data['location']?? ''),
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
              RoomTypeSection(
                propertyData: DetailPropertyModel.fromJson(widget.data),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacilityIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Color(0xFF004D40)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Color(0xFF004D40))),
      ],
    );
  }

  Widget _buildRoomFacilities() {

    final List<Map<String, String>> facilityMapping = [
      {'label': 'AC', 'key': 'Air Conditioning'},
      {'label': 'Bathroom', 'key': 'Private Bathroom'},
      {'label': 'Furnished', 'key': 'Furnished'},
      {'label': 'TV', 'key': 'TV Cable Ready'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: facilityMapping.map((facility) {
        final isAvailable = widget.data['data']['attributes']?['room_facilities'].contains(facility['key']);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isAvailable ? Icons.check_circle : Icons.cancel,
              color: isAvailable ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 4),
            Text(
              facility['label'] ?? '',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      }).toList(),
    );
  }
}
