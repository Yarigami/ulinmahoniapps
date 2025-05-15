import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/detailproperty_model.dart';
import '../data/detailhouse_services.dart';
import '../../../auth/login/provider/auth_provider.dart';

// Provider untuk PropertyService
final propertyServiceProvider = Provider((ref) => PropertyService());

// Provider untuk mengambil detail properti berdasarkan ID properti
final detailPropertyProvider = FutureProvider.family<DetailPropertyModel, int>((ref, propertyId) async {
  final authState = ref.watch(authProvider); // Ambil status login dari authProvider
  final user = authState.user.value;

  // Pastikan user sudah login
  if (user == null) {
    throw Exception("User not logged in");
  }

  // Pastikan ID user tersedia
  if (user.id == null) {
    throw Exception("User ID is null");
  }

  try {
    // Ambil instance service dari propertyServiceProvider
    final service = ref.read(propertyServiceProvider);

    // Ambil detail properti dengan memanggil method fetchDetailProperty dari service
    return await service.fetchDetailProperty(propertyId);
  } catch (e) {
    // Menangani error jika terjadi saat fetching
    throw Exception("Failed to fetch property detail: $e");
  }
});
