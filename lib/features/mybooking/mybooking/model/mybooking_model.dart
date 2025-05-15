class MyBookingModel {
  final int idrec;
  final String orderId;
  final int userId;
  final String? userName;
  final String? userPhoneNumber;
  final String propertyName;
  final String transactionDate;
  final String? checkIn;
  final String? checkOut;
  final String roomName;
  final String userEmail;
  final int bookingDays;
  final double dailyPrice;
  final double roomPrice;
  final double adminFees;
  final double grandTotalPrice;
  final String propertyType;
  final String transactionType;
  final String transactionCode;
  final String transactionStatus;
  final String status;
  final String? paidAt;
  final String createdAt;
  final String updatedAt;

  MyBookingModel({
    required this.idrec,
    required this.orderId,
    required this.userId,
    this.userName,
    this.userPhoneNumber,
    required this.propertyName,
    required this.transactionDate,
    this.checkIn,
    this.checkOut,
    required this.roomName,
    required this.userEmail,
    required this.bookingDays,
    required this.dailyPrice,
    required this.roomPrice,
    required this.adminFees,
    required this.grandTotalPrice,
    required this.propertyType,
    required this.transactionType,
    required this.transactionCode,
    required this.transactionStatus,
    required this.status,
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 🔄 FROM JSON
  factory MyBookingModel.fromJson(Map<String, dynamic> json) {
    return MyBookingModel(
      idrec: int.parse(json['idrec'].toString()),
      orderId: json['order_id'] ?? '',
      userId: int.parse(json['user_id'].toString()),
      userName: json['user_name'],
      userPhoneNumber: json['user_phone_number'],
      propertyName: json['property_name'] ?? '',
      transactionDate: json['transaction_date'] ?? '',
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      roomName: json['room_name'] ?? '',
      userEmail: json['user_email'] ?? '',
      bookingDays: int.parse(json['booking_days'].toString()),
      dailyPrice: double.parse(json['daily_price'].toString()),
      roomPrice: double.parse(json['room_price'].toString()),
      adminFees: double.parse(json['admin_fees'].toString()),
      grandTotalPrice: double.parse(json['grandtotal_price'].toString()),
      propertyType: json['property_type'] ?? '',
      transactionType: json['transaction_type'] ?? '',
      transactionCode: json['transaction_code'] ?? '',
      transactionStatus: json['transaction_status'] ?? '',
      status: json['status'] ?? '',
      paidAt: json['paid_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  /// 🔁 TO JSON
  Map<String, dynamic> toJson() {
    return {
      'idrec': idrec,
      'order_id': orderId,
      'user_id': userId,
      'user_name': userName,
      'user_phone_number': userPhoneNumber,
      'property_name': propertyName,
      'transaction_date': transactionDate,
      'check_in': checkIn,
      'check_out': checkOut,
      'room_name': roomName,
      'user_email': userEmail,
      'booking_days': bookingDays,
      'daily_price': dailyPrice,
      'room_price': roomPrice,
      'admin_fees': adminFees,
      'grandtotal_price': grandTotalPrice,
      'property_type': propertyType,
      'transaction_type': transactionType,
      'transaction_code': transactionCode,
      'transaction_status': transactionStatus,
      'status': status,
      'paid_at': paidAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
