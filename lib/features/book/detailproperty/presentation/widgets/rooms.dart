import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/productcard.dart';
import '../../../roomdetails/model/rooms_model.dart';
import '../../provider/rooms_provider.dart';
import '../../model/detailproperty_model.dart';

class RoomTypeSection extends ConsumerWidget {
  final DetailPropertyModel propertyData;
  const RoomTypeSection({Key? key, required this.propertyData}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int propertyId = propertyData.id ?? 0;
    final roomsAsyncValue = ref.watch(roomListProvider(propertyId));
    print(propertyData);
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
                        location: propertyData.location?? '-',
                        detail: room.descriptions ?? '-',
                        price: (room.price?['discounted']?['monthly'] ?? 0).toString(), // Konversi ke String
                        onTap: () {
                          print("========room=======");
                          print(propertyData);
                          print(room);
                          context.push('/roomdetails', extra: {
                            'property': propertyData,
                            'room': room,
                          });
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

  String _getImageFromRoom(RoomModel room) {
    try {
      final attachment = room.attachment;

      if (attachment is Map) {
        final image = attachment['image'] ?? attachment['url'];
        if (image is String && image.isNotEmpty) {
          return image;
        }
      } else if (attachment is String && attachment.isNotEmpty) {
        if (isBase64(attachment)) {
          return attachment;
        }
        return attachment;
      }
      return 'assets/images/ulinhouse.jpg';
    } catch (e) {
      debugPrint('Error in _getImageFromRoom: $e');
      return 'assets/images/ulinhouse.jpg';
    }
  }

  bool isBase64(String str) {
    try {
      base64Decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}