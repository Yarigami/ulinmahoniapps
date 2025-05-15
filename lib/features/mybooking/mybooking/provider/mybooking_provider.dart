import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/mybooking_model.dart';
import '../data/mybooking_services.dart';
import '../../../auth/login/provider/auth_provider.dart';

// Provider untuk service
final bookingServiceProvider = Provider((ref) => BookingService());

// Provider future untuk fetch data booking berdasarkan userId login
final userBookingsProvider = FutureProvider<List<MyBookingModel>>((ref) async {
  final authState = ref.watch(authProvider);
  final user = authState.user.value;

  // Pastikan user sudah login
  if (user == null) {
    throw Exception("User not logged in");
  }

  // Menambahkan log untuk memastikan ID yang digunakan benar
  print('✅User ID: ${user.id}');

  // Pastikan ID tidak null sebelum melakukan pemanggilan API
  if (user.id == null) {
    throw Exception("User ID is null");
  }

  // Mengambil instance booking service
  final service = ref.read(bookingServiceProvider);

  // Fetch data booking dengan ID user
  try {
    return await service.fetchBookingByUserId(user.id!);
  } catch (e) {
    throw Exception("(Prov)Failed to fetch bookings: $e");
  }
});
