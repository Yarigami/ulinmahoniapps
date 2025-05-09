class Transaction{
  final int idrec;
  final String orderId;
  final String? userName;
  final String? userPhoneNumber;
  final String propertyName;
  final String transactionDate;
  final String? checkIn;
  final String? checkOut;
  final String roomName;
  final String userEmail;
  final int bookingDays;
  final String dailyPrice;
  final String roomPrice;
  final String adminFees;
  final String grandTotalPrice;
  final String propertyType;
  final String transactionType;
  final String transactionCode;
  final String transactionStatus;
  final String status;
  final String? paidAt;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.idrec,
    required this.orderId,
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

  factory Transaction.fromJson(Map<String, dynamic> json){
    return Transaction(
      idrec: json['idrec'],
      orderId: json['order_id'],
      userName: json['user_name'],
      userPhoneNumber: json['user_phone_number'],
      propertyName: json['property_name'],
      transactionDate: json['transaction_date'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      roomName: json['room_name'],
      userEmail: json['user_email'],
      bookingDays: json['booking_days'],
      dailyPrice: json['daily_price'],
      roomPrice: json['room_price'],
      adminFees: json['admin_fees'],
      grandTotalPrice: json['grandtotal_price'],
      propertyType: json['property_type'],
      transactionType: json['transaction_type'],
      transactionCode: json['transaction_code'],
      transactionStatus: json['transaction_status'],
      status: json['status'],
      paidAt: json['paid_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}