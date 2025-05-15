import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../roomdetails/model/rooms_model.dart';
import '../../roomdetails/data/rooms_service.dart';

// Provider untuk RoomService
final roomServiceProvider = Provider((ref) => RoomService());

// Provider untuk mengambil daftar kamar berdasarkan ID properti
final roomListProvider = FutureProvider.family<List<RoomModel>, int>((ref, propertyId) async {
  try {
    // Ambil instance RoomService
    final service = ref.read(roomServiceProvider);

    // Ambil daftar kamar berdasarkan propertyId
    return await service.getRoomsByPropertyId(propertyId);
  } catch (e) {
    throw Exception("Failed to fetch rooms: $e");
  }
});