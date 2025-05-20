import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mybookingdetails_service.dart';

/// Provider untuk instance service
final myBookingDetailsServiceProvider = Provider<MyBookingDetailsService>((ref) {
  return MyBookingDetailsService();
});

/// FutureProvider untuk mendapatkan data booking berdasarkan `idrec`
final myBookingDetailsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, idrec) async {
  final service = ref.watch(myBookingDetailsServiceProvider);
  return service.getBookingDetailById(idrec);
});
