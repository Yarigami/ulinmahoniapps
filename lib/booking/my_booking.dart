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

  List<Map<String, dynamic>> _upcomingList =[
  {
    "name": "Ulin Mahoni West Jakarta",
    "type": "Alpha Room",
    "checkIn": DateTime(2025, 3, 15),
    "checkOut": DateTime(2025, 3, 17),
    "status": "On-going",
  },
  {
  "name": "Ulin Mahoni West Jakarta",
  "type": "Alpha Room",
  "checkIn": DateTime(2025, 3, 19),
  "checkOut": DateTime(2025, 3, 21),
  "status": "Waiting",
  },
  {
  "name": "Ulin Mahoni West Jakarta",
  "type": "Alpha Room",
  "checkIn": DateTime(2025, 3, 25),
  "checkOut": DateTime(2025, 3, 28),
  "status": "Upcoming",
  }
  ];

  List<Map<String, dynamic>> _completedList = [
    {
      "name": "Ulin Mahoni West Jakarta",
      "type": "Alpha Room",
      "checkIn": DateTime(2025, 3, 10),
      "checkOut": DateTime(2025, 3, 10),
    }
  ];
  bool isOldest = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void detailPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingDetail()));
  }

  void _sort(){
    setState(() {
      isOldest = !isOldest;
      _sortUpcoming();
      _sortCompleted();
    });
  }

  void _sortUpcoming(){
    _upcomingList.sort((x, y){
      int _compare = x['checkIn'].compareTo(y['checkin']);
      return isOldest ? _compare : _compare * -1;
    });
  }

  void _sortCompleted(){
    _completedList.sort((x, y){
      int _compare = x['checkIn'].compareTo(y['checkOut']);
      return isOldest ? _compare : _compare * -1;
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
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: toggleSort,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0d9488),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    isOldest ? "Sort: Oldest" : "Sort: Newest",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              )
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

        child: TabBarView(
          controller: _tabController,
          children: [
            _upcomingBookings(),
            _completedBookings(),
          ],
        ),
      ),
    );
  }

  Widget _upcomingCard({
    required String name,
    required String type,
    required String checkIn,
    required String checkOut,
    required String status,
  }) {
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
                          child: Text(name),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Row(
                      children: [
                        Text(type),
                        SizedBox(width: 6,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                          decoration: BoxDecoration(
                            color: status.toLowerCase() == "upcoming" ? Colors.red[100]
                                : status.toLowerCase() == "waiting" ? Colors.yellow[100] : Colors.green[100],
                            border: Border.all(color: status.toLowerCase() == "upcoming" ? Colors.red[800]!
                                : status.toLowerCase() == "waiting" ? Colors.yellow[800]! : Colors.green[800]!),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: status.toLowerCase() == "upcoming" ? Colors.red[900]
                                  : status.toLowerCase() == "waiting" ? Colors.yellow[900] : Colors.green[900],
                              fontSize: 10
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Text(checkIn),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Text(checkOut),
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

  Widget _completedCard({
    required String name,
    required String type,
    required String checkIn,
    required String checkOut,
  }) {
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
                        child: Text(name),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Text(type),
                  ),
                  // SizedBox(height: 4,),
                  TextButton(onPressed: detailPage,
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

  Widget _upcomingBookings() {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        _upcomingCard(
          name: "Ulin Mahoni West Jakarta",
          type: "Alpha Room",
          checkIn: "check in ${formattedDate(DateTime(2025, 3, 15))}" ,
          checkOut: "check out ${formattedDate(DateTime(2025, 3, 17))}",
          status: "On-going",
        ),
        _upcomingCard(
          name: "Ulin Mahoni West Jakarta",
          type: "Alpha Room",
          checkIn: "check in ${formattedDate(DateTime(2025, 3, 19))}",
          checkOut: "check out ${formattedDate(DateTime(2025, 3, 21))}",
          status: "Waiting",
        ),
        _upcomingCard(
          name: "Ulin Mahoni West Jakarta",
          type: "Alpha Room",
          checkIn: "check in ${formattedDate(DateTime(2025, 3, 25))}",
          checkOut: "check out ${formattedDate(DateTime(2025, 3, 28))}",
          status: "Upcoming",
        ),
      ],
    );
  }

  Widget _completedBookings() {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        _completedCard(
          name: "Ulin Mahoni West Jakarta",
          type: "Alpha Room",
          checkIn: "check in 10 Mar 2025",
          checkOut: "check out 12 Mar 2025",
        ),
      ],
    );
  }

  String formattedDate(DateTime date){
    return DateFormat('dd MMM yyyy').format(date);
  }
}
