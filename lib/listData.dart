class ListData {
  String image;
  String name;
  String type;
  DateTime checkIn;
  DateTime checkOut;
  double hpm;
  int duration;
  double discount;
  late double total;
  late double ftotal;
  // String status;

  ListData({
    required this.image,
    required this.name,
    required this.type,
    required this.checkIn,
    required this.checkOut,
    required this.hpm,
    required this.duration,
    required this.discount,
    required this.total,
    required this.ftotal,
    // required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "type": type,
      "checkIn": checkIn,
      "checkOut": checkOut,
      "hpm": hpm,
      "duration": duration,
      "discount": discount,
      "total": total,
      "ftotal": ftotal,
      // "status": status,
    };
  }
}

List<ListData> myList = [
  ListData(
      image: "assets/images/house.png",
      name: "Ulin Mahoni Jakarta",
      type: "Beta Room",
      checkIn: DateTime(2025, 3, 6),
      checkOut: DateTime(2025, 3, 7),
      hpm: 300000,
      duration: 3,
      total: 900000,
      discount: 0,
      ftotal: 900000,
      // status: "completed",
  ),
];
