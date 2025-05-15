class BookingRequest {
  final int userId;
  final String? userName;
  final String userPhoneNumber;
  final String propertyId;
  final String propertyName;
  final String checkIn;
  final String checkOut;
  final String roomName;
  final String userEmail;
  final int? dailyPrice;
  final int? monthlyPrice;
  final String propertyType;

  BookingRequest({
    required this.userId,
    required this.userName,
    required this.userPhoneNumber,
    required this.propertyId,
    required this.propertyName,
    required this.checkIn,
    required this.checkOut,
    required this.roomName,
    required this.userEmail,
    required this.dailyPrice,
    required this.monthlyPrice,
    required this.propertyType,
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
      'user_email': userEmail,
      'daily_price': dailyPrice,
      'monthly_price':monthlyPrice,
      'property_type': propertyType,
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
      userEmail: json['user_email'],
      dailyPrice: json['daily_price'],
      monthlyPrice: json['monthly_price'],
      propertyType: json['property_type'],
    );
  }
}
