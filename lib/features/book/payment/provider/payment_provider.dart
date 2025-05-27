import 'dart:convert';
import '../data/payment_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/login/provider/auth_provider.dart';

final paymentProvider = StateNotifierProvider<PaymentNotifier, AsyncValue<String>>((ref) {
  return PaymentNotifier(ref); // ⬅️ inject ref di sini
});

class PaymentNotifier extends StateNotifier<AsyncValue<String>> {
  final Ref ref; // ⬅️ simpan ref agar bisa digunakan di class

  PaymentNotifier(this.ref) : super(const AsyncValue.data(''));

  Future<void> postBooking(Map<String, dynamic> bookingData) async {
    state = const AsyncValue.loading();

    print('--- Data Booking yang Akan Dikirim ---');
    print(jsonEncode(bookingData)); // Menggunakan jsonEncode untuk format JSON yang rapi
    print('-------------------------------------');

    try {
      final authState = ref.watch(authProvider);
      final user = authState.user.value;
      if (user == null) {
        throw Exception("User not logged in");
      }

      final response = await PaymentService.postBooking(bookingData: bookingData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final message = data['message'] ?? 'Booking berhasil';
        state = AsyncValue.data(message);
      } else {
        final error = jsonDecode(response.body);
        final message = error['message'] ?? 'Terjadi kesalahan saat booking';
        state = AsyncValue.error(message, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }
}
