import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/detailproperty_model.dart';
import '../data/detailhouse_services.dart';
import 'package:flutter/foundation.dart'; // Import kDebugMode

// Provider untuk PropertyService
final propertyServiceProvider = Provider((ref) => PropertyService());

// Provider untuk mengambil detail properti berdasarkan ID properti
final detailPropertyProvider = FutureProvider.family<DetailPropertyModel, int>((ref, propertyId) async {
  try {
    // Ambil instance service dari propertyServiceProvider
    final service = ref.read(propertyServiceProvider);

    // Ambil detail properti dengan memanggil method fetchDetailProperty dari service
    return await service.fetchDetailProperty(propertyId);
  } catch (e, stackTrace) {
    // Menangani error jika terjadi saat fetching
    if (kDebugMode) {
      print('Failed to fetch property detail: $e');
      print('Stack trace: $stackTrace');
    }
    throw Exception("Failed to fetch property detail: $e");
  }
});