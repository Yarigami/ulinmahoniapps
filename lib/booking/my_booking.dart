import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'booking_detail.dart';
import 'package:ulinmahoniapps/profile/profile_page.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final String image = "assets/images/house.png";
  final String name = "Ulin Mahoni West Jakarta";
  final String type = "Alpha Room";
  final DateTime checkIn = DateTime(2025, 3, 7);
  final DateTime checkOut = DateTime(2025, 3, 10);
  final double hpm = 200000;
  final int duration = 3;
  final double discount = 0.1;
  late double total = hpm * duration;
  late double ftotal = 540000;

  final List<Map<String, dynamic>> _upcomingList =[
  {
    "image": "assets/images/house.png",
    "name": "Ulin Mahoni West Jakarta",
    "type": "Alpha Room",
    "checkIn": DateTime(2025, 3, 15),
    "checkOut": DateTime(2025, 3, 17),
    "status": "On-going",
  },
  {
    "image": "assets/images/house.png",
    "name": "Ulin Mahoni West Jakarta",
    "type": "Alpha Room",
    "checkIn": DateTime(2025, 3, 19),
    "checkOut": DateTime(2025, 3, 21),
    "status": "Waiting",
  },
  {
    "image": "assets/images/house.png",
    "name": "Ulin Mahoni West Jakarta",
    "type": "Alpha Room",
    "checkIn": DateTime(2025, 3, 25),
    "checkOut": DateTime(2025, 3, 28),
    "status": "Upcoming",
  }
  ];

  late List<Map<String, dynamic>> _completedList; //= [
  //   {
  //     "image": "assets/images/house.png",
  //     "name": "Ulin Mahoni West Jakarta",
  //     "type": "Alpha Room",
  //     "checkIn": DateTime(2025, 3, 10),
  //     "checkOut": DateTime(2025, 3, 10),
  //     "hpm": hpm,
  //     "duration": duration,
  //     "total": total,
  //     "discount": discount,
  //     "final": ftotal
  //   },
  //   {
  //     "image": "assets/images/house.png",
  //     "name": "Ulin Mahoni East Jakarta",
  //     "type": "Alpha Room",
  //     "checkIn": DateTime(2025, 3, 1),
  //     "checkOut": DateTime(2025, 3, 5),
  //   }
  // ];
  bool isOldest = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _completedList = [
      {
        "image": image,
        "name": name,
        "type": type,
        "checkIn": checkIn,
        "checkOut": checkOut,
        "hpm": hpm,
        "duration": duration,
        "total": total,
        "discount": discount,
        "ftotal": ftotal
      },
      {
        "image": "assets/images/house.png",
        "name": "Ulin Mahoni East Jakarta",
        "type": "Beta Room",
        "checkIn": DateTime(2025, 3, 3),
        "checkOut": DateTime(2025, 3, 5),
        "hpm": 300000,
        "duration": 3,
        "total": 900000,
        "discount": 0,
        "ftotal": 900000
      }
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void detailPage(Map<String, dynamic> booking){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookingDetail(booking: booking)));
  }

  void _sortUpcoming(){
    _upcomingList.sort((x, y){
      int comparing = x['checkIn'].compareTo(y['checkIn']);
      return isOldest ? comparing : comparing * -1;
    });
  }

  void _sortCompleted(){
    _completedList.sort((x, y){
      int comparing = x['checkOut'].compareTo(y['checkOut']);
      return isOldest ? comparing : comparing * -1;
    });
  }

  void toggleSort(){
    setState(() {
      isOldest = !isOldest;
      _sortUpcoming();
      _sortCompleted();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF5F2EA),
      appBar: AppBar(
        title: Text("My Booking", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFd2c8ae), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: PreferredSize(// USE TO SEPERATE THE TEXTBUTTON
          preferredSize: Size.fromHeight(56),//SIZE STARTING FROM THE END OF THE TEXTBUTTON HEIGHT
          child: Column(
            children: [
              Container(height: 28, color: Colors.white,),
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Color(0xFFF5F2EA),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  // indicatorColor: Colors.black,
                  labelColor: Color(0xFF0d9488),
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(child: SizedBox(width: 300, child: Center(child: Text("Upcoming", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),))),
                    Tab(child: SizedBox(width: 300, child: Center(child: Text("Completed", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),)),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F2EA), Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 4, 0, 0)),
            ElevatedButton(
              onPressed: toggleSort,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0d9488),
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                isOldest ? "Sort: Oldest" : "Sort: Newest",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _upcomingBookings(),
                  _completedBookings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _upcomingCard({required Map<String, dynamic> booking}) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 4),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.circular(12),
              child: Image.asset("assets/images/house.png",
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 11,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.apartment, size: 20,),
                      SizedBox(width: 8,),
                      Expanded(
                          child: Text(booking['name']),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Row(
                      children: [
                        Text(booking['type']),
                        SizedBox(width: 6,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                          decoration: BoxDecoration(
                            color: booking['status'].toLowerCase() == "upcoming" ? Colors.red[100]
                                : booking['status'].toLowerCase() == "waiting" ? Colors.yellow[100] : Colors.green[100],
                            border: Border.all(color: booking['status'].toLowerCase() == "upcoming" ? Colors.red[800]!
                                : booking['status'].toLowerCase() == "waiting" ? Colors.yellow[800]! : Colors.green[800]!),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            booking['status'],
                            style: TextStyle(
                              color: booking['status'].toLowerCase() == "upcoming" ? Colors.red[900]
                                  : booking['status'].toLowerCase() == "waiting" ? Colors.yellow[900] : Colors.green[900],
                              fontSize: 10
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Text("Check-in: ${formattedDate(booking['checkIn'])}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Text("Check-out: ${formattedDate(booking['checkOut'])}"),
                  ),
                  SizedBox(height: 4,),
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _completedCard({required Map<String, dynamic> booking}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.circular(12),
              child: Image.asset("assets/images/house.png",
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 11,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.apartment, size: 20,),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text(booking['name']),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Text(booking['type']),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Text("Check-out: ${formattedDate(booking['checkOut'])}"),
                  ),
                  // SizedBox(height: 4,),
                  TextButton(onPressed: () => detailPage(booking),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0d9488)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                        child: Text("Booking Detail"),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _upcomingBookings(){
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: _upcomingList.length,
      itemBuilder: (context, index){
        return _upcomingCard(booking: _upcomingList[index]);
      },
    );
  }

  Widget _completedBookings() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: _completedList.length,
      itemBuilder: (context, index){
        return _completedCard(booking: _completedList[index]
        );
      },
    );
  }

  String formattedDate(DateTime date){
    return DateFormat('dd MMM yyyy').format(date);
  }
}
