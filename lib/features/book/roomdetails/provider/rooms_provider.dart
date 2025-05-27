import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/rooms_model.dart';
import '../data/rooms_service.dart';

// Provider untuk RoomService
final roomServiceProvider = Provider((ref) => RoomService());

// Provider untuk mengambil daftar kamar berdasarkan ID properti
final roomListProvider = FutureProvider.family<List<RoomModel>, int>((ref, propertyId) async {
  try {
    // Ambil instance RoomService
    final service = ref.read(roomServiceProvider);

    // Ambil daftar kamar berdasarkan propertyId
    return await service.getRoomsByPropertyId(propertyId);
  } catch (e, stackTrace) {
    print('Error fetching rooms for propertyId $propertyId: $e');
    print('StackTrace: $stackTrace');
    throw Exception("Failed to fetch rooms: $e");
  }
});