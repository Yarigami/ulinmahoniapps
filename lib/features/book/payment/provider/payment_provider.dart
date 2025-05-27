import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulinmahoniapps/features/book/detailproperty/model/detailproperty_model.dart';
import 'package:ulinmahoniapps/features/book/roomdetails/model/rooms_model.dart';
import 'package:ulinmahoniapps/features/book/payment/model/payment_model.dart';
import 'package:ulinmahoniapps/features/auth/login/provider/auth_provider.dart';
import '../data/payment_services.dart'; // Pastikan path ini benar

// --- Helper Functions (pindahkan ke file utils jika sudah ada) ---
// Sebaiknya fungsi-fungsi ini berada di `lib/core/utils/parser_utils.dart`
// dan diimpor saja ke sini untuk menghindari duplikasi.
double parseToDouble(dynamic value) {
  if (value == null) return 0.0;
  String stringValue = value.toString().replaceAll('Rp', '').replaceAll(' ', '');
  return double.tryParse(stringValue) ?? 0.0;
}

int parseToInt(dynamic value) {
  if (value == null) return 0;
  String stringValue = value.toString().replaceAll('Rp', '').replaceAll(' ', '');
  return double.tryParse(stringValue)?.toInt() ?? 0;
}

// --- PaymentState (State gabungan untuk PaymentNotifier) ---
class PaymentState {
  // State untuk data perhitungan pembayaran (dari PaymentDetailsNotifier sebelumnya)
  final AsyncValue<Map<String, dynamic>> paymentCalculationData;
  // State untuk hasil postBooking (dari PaymentNotifier sebelumnya)
  final AsyncValue<String?> postBookingResult;

  PaymentState({
    required this.paymentCalculationData,
    this.postBookingResult = const AsyncValue.data(null),
  });

  // Method copyWith untuk memudahkan update state
  PaymentState copyWith({
    AsyncValue<Map<String, dynamic>>? paymentCalculationData,
    AsyncValue<String?>? postBookingResult,
  }) {
    return PaymentState(
      paymentCalculationData: paymentCalculationData ?? this.paymentCalculationData,
      postBookingResult: postBookingResult ?? this.postBookingResult,
    );
  }
}

// --- PaymentNotifier (Notifier yang sudah digabungkan) ---
final paymentNotifierProvider = StateNotifierProvider<PaymentNotifier, PaymentState>((ref) {
  return PaymentNotifier(ref);
});

class PaymentNotifier extends StateNotifier<PaymentState> {
  final Ref _ref;

  PaymentNotifier(this._ref)
      : super(PaymentState(paymentCalculationData: const AsyncValue.loading()));

  // === Bagian Logika Perhitungan Pembayaran (dari PaymentDetailsNotifier) ===

  Future<void> loadPaymentDetails({
    required RoomModel room,
    required DetailPropertyModel propertyData,
    required String rentType,
    required int duration,
    required DateTime checkInDate,
    required DateTime checkOutDate,
  }) async {
    state = state.copyWith(paymentCalculationData: const AsyncValue.loading());
    try {
      print("====Fetching Payment Data in Notifier (Combined)====");

      final originalDailyPrice = parseToDouble(room.priceOriginalDaily);
      final originalMonthlyPrice = parseToDouble(room.priceOriginalMonthly);

      double originalTotal = 0;
      int monthlyDurationCalculated = 0;
      int dailyDurationCalculated = 0;

      if (rentType == 'daily') {
        originalTotal = originalDailyPrice * duration;
        dailyDurationCalculated = duration;
      } else if (rentType == 'monthly') {
        originalTotal = originalMonthlyPrice * duration;
        monthlyDurationCalculated = duration;
      }

      final adminFee = 0;
      // final adminFee = originalTotal * 0.10; // Admin fee berdasarkan harga normal

      final roomDetails = {
        'name': room.name ?? '-',
        'id': room.id ?? '',
        'checkIn': checkInDate.toString().substring(0, 10),
        'checkOut': checkOutDate.toString().substring(0, 10),
        'type': room.type ?? '-',
        'propertyName': propertyData.name ?? '-',
        'propertyId': propertyData.id ?? '',
        'propertyType': propertyData.tags ?? '-',
        'location': propertyData.location ?? '-',
        'daily_price': originalDailyPrice,
        'monthly_price': originalMonthlyPrice,
        'rentType': rentType,
        'booking_months': monthlyDurationCalculated,
        'booking_days': dailyDurationCalculated,
        'admin_fee': adminFee,
      };

      final List<Map<String, dynamic>> itemDetails = [
        {
          'name': '$duration ${rentType == 'daily' ? 'Hari' : 'Bulan'} (Harga Normal)',
          'price': originalTotal.toStringAsFixed(0),
          'rawPrice': originalTotal,
          'type': 'original',
        },
      ];

      final Map<String, dynamic> combinedData = {
        'roomData': roomDetails,
        'itemDetails': itemDetails,
        'afterOriginalTotalFees': adminFee,
      };

      state = state.copyWith(paymentCalculationData: AsyncValue.data(combinedData));
      print("====Payment Data Loaded (Combined)==== : $combinedData");
    } catch (e, st) {
      print("Error loading payment details (Combined): $e\n$st");
      state = state.copyWith(paymentCalculationData: AsyncValue.error(e, st));
    }
  }

  // Fungsi untuk menghitung total harga
  double calculateTotalPrice(List<Map<String, dynamic>> items, double taxFee) {
    double totalPrice = 0;
    for (var item in items) {
      if (item['type'] == 'original') {
        totalPrice += parseToDouble(item['rawPrice']);
      }
    }
    totalPrice += taxFee;
    return totalPrice;
  }

  // === Bagian Logika Post Booking API (dari PaymentNotifier sebelumnya) ===

  Future<void> postBooking() async {
    state = state.copyWith(postBookingResult: const AsyncValue.loading());

    final user = _ref.read(authProvider).user.value;
    if (user == null) {
      state = state.copyWith(postBookingResult: AsyncValue.error('User not logged in', StackTrace.current));
      return;
    }

    final currentPaymentData = state.paymentCalculationData.value;
    if (currentPaymentData == null) {
      state = state.copyWith(postBookingResult: AsyncValue.error('Payment calculation data not loaded', StackTrace.current));
      return;
    }

    final roomDetails = currentPaymentData['roomData'] as Map<String, dynamic>;

    final bookingRequest = BookingRequest(
      userId: user.id,
      userName: user.name,
      userPhoneNumber: '090847289729', // Ganti dengan data dari input user
      propertyId: roomDetails['propertyId'].toString(),
      propertyName: roomDetails['propertyName'].toString(),
      checkIn: roomDetails['checkIn'].toString(),
      checkOut: roomDetails['checkOut'].toString(),
      roomName: roomDetails['name'].toString(),
      roomId: roomDetails['id'].toString(),
      userEmail: user.email,
      dailyPrice: parseToDouble(roomDetails['daily_price']),
      monthlyPrice: parseToDouble(roomDetails['monthly_price']),
      adminfee: parseToDouble(roomDetails['admin_fee']),
      propertyType: roomDetails['propertyType'].toString(),
      bookingType: roomDetails['rentType'].toString(),
      bookingDays: roomDetails['booking_days'],
      bookingMonths: roomDetails['booking_months'],
    );

    print('--- Data Booking yang Akan Dikirim ---');
    print(jsonEncode(bookingRequest.toJson()));
    print('-------------------------------------');

    try {
      final response = await PaymentService.postBooking(bookingData: bookingRequest.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final message = data['message'] ?? 'Booking berhasil';
        state = state.copyWith(postBookingResult: AsyncValue.data(message));
      } else {
        final error = jsonDecode(response.body);
        final message = error['message'] ?? 'Terjadi kesalahan saat booking';
        state = state.copyWith(postBookingResult: AsyncValue.error(message, StackTrace.current));
      }
    } catch (e, st) {
      state = state.copyWith(postBookingResult: AsyncValue.error(e.toString(), st));
    }
  }
}