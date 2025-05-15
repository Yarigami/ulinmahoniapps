import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/productcard.dart';
import '../../model/rooms_model.dart';
import '../../provider/rooms_provider.dart';

class RoomTypeSection extends ConsumerWidget {
  final dynamic propertyData;

  const RoomTypeSection({Key? key, required this.propertyData}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int propertyId = propertyData['id'] ?? 0;

    final roomsAsyncValue = ref.watch(roomListProvider(propertyId));

    return Container(
      width: double.infinity,
      color: const Color(0xFFECE7DE),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Room Type',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          roomsAsyncValue.when(
            data: (rooms) {
              if (rooms.isEmpty) {
                return const Text('No rooms available.');
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: rooms.map((RoomModel room) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ProductCard(
                        image: _getImageFromRoom(room),
                        title: room.name ?? '-',
                        location: propertyData['name'] ?? '-',
                        detail: room.descriptions ?? '-',
                        price: room.price?['original']?['daily'] ?? 0,
                        onTap: () {
                          context.push('/bookhouse', extra: room);
                        },
                        width: 200,
                        height: 250,
                        imageHeight: 150,
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // Helper untuk ambil gambar dari attachment, fallback jika kosong
  String _getImageFromRoom(RoomModel room) {
    try {
      final attachment = room.attachment;
      if (attachment != null) {
        // Cek dulu kalau ada key image atau url sebagai String
        if (attachment['image'] != null && attachment['image'] is String) {
          return attachment['image'];
        }
        if (attachment['url'] != null && attachment['url'] is String) {
          return attachment['url'];
        }
      }
      // Jika tidak ditemukan, fallback gambar default (misal asset lokal)
      return 'assets/images/default_room.jpg';
    } catch (e) {
      print('Error in _getImageFromRoom: $e');
      return 'assets/images/default_room.jpg';
    }
  }
}
