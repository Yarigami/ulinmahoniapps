import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Untuk DateFormat
import '../model/rooms_model.dart';
import '../../detailproperty/model/detailproperty_model.dart';

// Definisi State Notifier untuk mengelola state Room Details
class RoomDetailsNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  RoomDetailsNotifier() : super(const AsyncValue.data({
    'room': null,
    'propertyData': null,
    'rentType': null,
    'duration': null,
    'checkInDate': null,
    'checkOutDate': null,
    'checkInDateController': null, // TextEditingController sebaiknya tidak di maintain di sini
    'checkOutDateController': null, // TextEditingController sebaiknya tidak di maintain di sini
  }));

  // Inisialisasi controller di widget atau dilewatkan
  // Atau, jika benar-benar harus di sini, pastikan didispose.
  // TextEditingController _checkInDateController = TextEditingController();
  // TextEditingController _checkOutDateController = TextEditingController();

  void loadRoomDetails(RoomModel room, DetailPropertyModel property) {
    state = AsyncValue.data({
      ...state.value!, // Pertahankan state yang ada
      'room': room,
      'propertyData': property,
    });
    // Jika controller perlu direset/dibersihkan setelah loading, lakukan di sini
    // _checkInDateController.clear();
    // _checkOutDateController.clear();
  }

  void updateRentType(String? newRentType) {
    state = AsyncValue.data({
      ...state.value!,
      'rentType': newRentType,
      'duration': null, // Reset duration saat rentType berubah
      'checkInDate': null, // Reset tanggal
      'checkOutDate': null, // Reset tanggal
    });
  }

  void updateDuration(int? newDuration) {
    state = AsyncValue.data({
      ...state.value!,
      'duration': newDuration,
    });
    // Panggil updateCheckOutDate setelah duration diupdate
    updateCheckOutDate();
  }

  void updateCheckInDate(DateTime? pickedDate) {
    if (pickedDate != null) {
      final checkIn = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 14, 0); // 2 PM
      state = AsyncValue.data({
        ...state.value!,
        'checkInDate': checkIn,
      });
      // Jika Anda menggunakan TextEditingController, Anda harus mengupdate teksnya di widget
      updateCheckOutDate();
    }
  }

  void updateCheckOutDate() {
    final currentState = state.value!;
    final checkInDate = currentState['checkInDate'] as DateTime?;
    final duration = currentState['duration'] as int?;
    final rentType = currentState['rentType'] as String?;

    if (checkInDate != null && duration != null) {
      DateTime checkOut;
      if (rentType == 'daily') {
        checkOut = checkInDate.add(Duration(days: duration));
      } else { // 'monthly'
        checkOut = DateTime(
          checkInDate.year,
          checkInDate.month + duration,
          checkInDate.day,
        );
      }
      final checkOutWithTime = DateTime(checkOut.year, checkOut.month, checkOut.day, 12, 0); // 12 PM
      state = AsyncValue.data({
        ...state.value!,
        'checkOutDate': checkOutWithTime,
      });
      // Jika Anda menggunakan TextEditingController, Anda harus mengupdate teksnya di widget
    } else {
      state = AsyncValue.data({
        ...state.value!,
        'checkOutDate': null,
      });
    }
  }

  // Metode untuk mendapatkan state sebagai bookingData
  Map<String, dynamic> getBookingData() {
    return state.value!;
  }

  // Contoh untuk membersihkan state jika diperlukan
  void resetState() {
    state = const AsyncValue.data({
      'room': null,
      'propertyData': null,
      'rentType': null,
      'duration': null,
      'checkInDate': null,
      'checkOutDate': null,
    });
    // _checkInDateController.clear();
    // _checkOutDateController.clear();
  }
}

// Provider untuk RoomDetailsNotifier
final roomDetailsProvider = StateNotifierProvider<RoomDetailsNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return RoomDetailsNotifier();
});