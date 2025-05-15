class MyBookingModel {
  final int? idrec;
  final String? propertyId;
  final String? roomId;
  final String? orderId;
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? userPhoneNumber;
  final String? propertyName;
  final String? propertyType;
  final String? roomName;
  final String? bookingType;
  final int? bookingDays;
  final double? dailyPrice;
  final int? bookingMonths;
  final double? monthlyPrice;
  final String? checkIn;       // Ubah jadi String?
  final String? checkOut;      // Ubah jadi String?
  final double? roomPrice;
  final double? adminFees;
  final double? grandTotalPrice;
  final String? transactionDate; // Ubah jadi String?
  final String? transactionType;
  final String? transactionCode;
  final String? transactionStatus;
  final String? status;// karena dari API status kadang int/ string
  final String? paidAt;        // Ubah jadi String?
  final String? attachment;
  final String? createdAt;     // Ubah jadi String?
  final String? updatedAt;     // Ubah jadi String?

  MyBookingModel({
    this.idrec,
    this.propertyId,
    this.roomId,
    this.orderId,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhoneNumber,
    this.propertyName,
    this.propertyType,
    this.roomName,
    this.bookingType,
    this.bookingDays,
    this.dailyPrice,
    this.bookingMonths,
    this.monthlyPrice,
    this.checkIn,
    this.checkOut,
    this.roomPrice,
    this.adminFees,
    this.grandTotalPrice,
    this.transactionDate,
    this.transactionType,
    this.transactionCode,
    this.transactionStatus,
    this.status,
    this.paidAt,
    this.attachment,
    this.createdAt,
    this.updatedAt,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) {
    return MyBookingModel(
      idrec: json['idrec'],
      propertyId: json['property_id']?.toString(),
      roomId: json['room_id']?.toString(),
      orderId: json['order_id'],
      userId: json['user_id'],
      userName: json['user_name'],
      userEmail: json['user_email'],
      userPhoneNumber: json['user_phone_number'],
      propertyName: json['property_name'],
      propertyType: json['property_type'],
      roomName: json['room_name'],
      bookingType: json['booking_type'],
      bookingDays: json['booking_days'],
      dailyPrice: (json['daily_price'] != null) ? double.tryParse(json['daily_price'].toString()) : null,
      bookingMonths: json['booking_months'],
      monthlyPrice: (json['monthly_price'] != null) ? double.tryParse(json['monthly_price'].toString()) : null,
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      roomPrice: (json['room_price'] != null) ? double.tryParse(json['room_price'].toString()) : null,
      adminFees: (json['admin_fees'] != null) ? double.tryParse(json['admin_fees'].toString()) : null,
      grandTotalPrice: (json['grandtotal_price'] != null) ? double.tryParse(json['grandtotal_price'].toString()) : null,
      transactionDate: json['transaction_date'],
      transactionType: json['transaction_type'],
      transactionCode: json['transaction_code'],
      transactionStatus: json['transaction_status'],
      status: json['status']?.toString(),
      paidAt: json['paid_at'],
      attachment: json['attachment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      'grandtotal_price': grandTotalPrice,
      'transaction_date': transactionDate,
      'transaction_type': transactionType,
      'transaction_code': transactionCode,
      'transaction_status': transactionStatus,
      'status': status,
      'paid_at': paidAt,
      'attachment': attachment,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
