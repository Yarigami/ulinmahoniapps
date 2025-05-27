import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/login/provider/auth_provider.dart';
import '../presentation/widgets/mybooking_card.dart';

List<Widget> buildBookingList(List bookings, String status) {
  final lowerStatus = status.toLowerCase();

  return bookings
      .where((booking) {
    final bookingStatus = booking.transactionStatus?.toLowerCase() ?? '';

    if (lowerStatus == 'all bookings') {
      return bookingStatus == 'pending' ||
          bookingStatus == 'waiting' ||
          bookingStatus == 'canceled';
    } else {
      return bookingStatus == 'completed' ||
          bookingStatus == 'success';
    }
  })
      .map((booking) => BookingCard(
    id: booking.idrec,
    image: 'assets/images/ulinhouse.jpg',
    title: booking.propertyName ?? '-',
    roomName: booking.roomName ?? '-',
    checkIn: booking.checkIn ?? '-',
    checkOut: booking.checkOut ?? '-',
    status: booking.transactionStatus ?? '-',
    dataDetail: booking.toJson(),
  ))
      .toList();
}

bool checkLoginAndRedirect(BuildContext context, WidgetRef ref) {
  final authState = ref.read(authProvider);
  final user = authState.user.value;

  if (user == null || user.id == null) {
    Future.microtask(() => context.push('/login'));
    return false;
  }

  return true;
}
