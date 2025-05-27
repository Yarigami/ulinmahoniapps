class MyBookingModel {
  final int idrec;
  final String propertyId;
  final String roomId;
  final String orderId;
  final int userId;
  final String userName;
  final String userEmail;
  final String? userPhoneNumber;
  final String propertyName;
  final String? propertyType;
  final String? roomName;
  final String? bookingType;
  final int? bookingDays;
  final String? dailyPrice;
  final int? bookingMonths;
  final String? monthlyPrice;
  final String? checkIn;
  final String? checkOut;
  final String roomPrice;
  final String adminFees;
  final String grandtotalPrice;
  final String? transactionDate;
  final String transactionType;
  final String transactionCode;
  final String transactionStatus;
  final String status;
  final String? paidAt;
  final String? attachment;

  MyBookingModel({
    required this.idrec,
    required this.propertyId,
    required this.roomId,
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userPhoneNumber,
    required this.propertyName,
    required this.propertyType,
    required this.roomName,
    this.bookingType,
    this.bookingDays,
    this.dailyPrice,
    this.bookingMonths,
    this.monthlyPrice,
    required this.checkIn,
    required this.checkOut,
    required this.roomPrice,
    required this.adminFees,
    required this.grandtotalPrice,
    required this.transactionDate,
    required this.transactionType,
    required this.transactionCode,
    required this.transactionStatus,
    required this.status,
    this.paidAt,
    this.attachment,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) {
    return MyBookingModel(
      idrec: json['idrec'] ?? 0,
      propertyId: json['property_id'] ?? '',
      roomId: json['room_id'] ?? '',
      orderId: json['order_id'] ?? '',
      userId: json['user_id'] ?? 0,
      userName: json['user_name'] ?? '',
      userEmail: json['user_email'] ?? '',
      userPhoneNumber: json['user_phone_number'],
      propertyName: json['property_name'] ?? '',
      propertyType: json['property_type'] ?? '',
      roomName: json['room_name'] ?? '',
      bookingType: json['booking_type'],
      bookingDays: json['booking_days'],
      dailyPrice: json['daily_price'],
      bookingMonths: json['booking_months'],
      monthlyPrice: json['monthly_price'],
      checkIn: json['check_in'] ?? '',
      checkOut: json['check_out'] ?? '',
      roomPrice: json['room_price'] ?? '0',
      adminFees: json['admin_fees'] ?? '0',
      grandtotalPrice: json['grandtotal_price'] ?? '0',
      transactionDate: json['transaction_date'] ?? '',
      transactionType: json['transaction_type'] ?? '',
      transactionCode: json['transaction_code'] ?? '',
      transactionStatus: json['transaction_status'] ?? '',
      status: json['status'] ?? '',
      paidAt: json['paid_at'] ?? '',
      attachment: json['attachment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idrec': idrec,
      'property_id': propertyId,
      'room_id': roomId,
      'order_id': orderId,
      'user_id': userId,
      'user_name': userName,
      'user_email': userEmail,
      'user_phone_number': userPhoneNumber,
      'property_name': propertyName,
      'property_type': propertyType,
      'room_name': roomName,
      'booking_type': bookingType,
      'booking_days': bookingDays,
      'daily_price': dailyPrice,
      'booking_months': bookingMonths,
      'monthly_price': monthlyPrice,
      'check_in': checkIn,
      'check_out': checkOut,
      'room_price': roomPrice,
      'admin_fees': adminFees,
      'grandtotal_price': grandtotalPrice,
      'transaction_date': transactionDate,
      'transaction_type': transactionType,
      'transaction_code': transactionCode,
      'transaction_status': transactionStatus,
      'status': status,
      'paid_at': paidAt,
      'attachment': attachment,
    };
  }
}
