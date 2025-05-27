class BookingRequest {
  final int userId;
  final String? userName;
  final String userPhoneNumber;
  final String propertyId;
  final String propertyName;
  final String checkIn;
  final String checkOut;
  final String roomName;
  final String roomId;
  final String userEmail;
  final String bookingType;
  final double? dailyPrice;
  final double? monthlyPrice;
  final double? adminfee;
  final String propertyType;
  final int? bookingDays;
  final int? bookingMonths;

  BookingRequest({
    required this.userId,
    required this.userName,
    required this.userPhoneNumber,
    required this.propertyId,
    required this.propertyName,
    required this.checkIn,
    required this.checkOut,
    required this.roomName,
    required this.roomId,
    required this.userEmail,
    this.dailyPrice,
    this.monthlyPrice,
    required this.adminfee,
    required this.propertyType,
    required this.bookingType,
    this.bookingDays,
    this.bookingMonths,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'user_phone_number': userPhoneNumber,
      'property_id': propertyId,
      'property_name': propertyName,
      'check_in': checkIn,
      'check_out': checkOut,
      'room_name': roomName,
      'room_id': roomId,
      'user_email': userEmail,
      'daily_price': dailyPrice,
      'monthly_price':monthlyPrice,
      'admin_fees': adminfee,
      'property_type': propertyType,
      'booking_type': bookingType,
      'booking_days': bookingDays,
      'booking_months': bookingMonths,
    };
  }

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      userId: json['user_id'],
      userName: json['user_name'],
      userPhoneNumber: json['user_phone_number'],
      propertyId: json['property_id'],
      propertyName: json['property_name'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      roomName: json['room_name'],
      roomId: json['room_id'],
      userEmail: json['user_email'],
      dailyPrice: json['daily_price'],
      monthlyPrice: json['monthly_price'],
      adminfee: json['admin_fees'],
      propertyType: json['property_type'],
      bookingType: json['booking_type'],
      bookingDays: json['booking_days'],
      bookingMonths: json['booking_months'],
    );
  }
}
