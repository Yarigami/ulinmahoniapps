import 'package:flutter/material.dart';
import 'booking_detail.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(onPressed: (){},
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            ),
            Text("My Booking", style: TextStyle(color: Colors.white),),
          ],
        ),
        // title: Text("My Booking", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green.shade700,
        bottom: PreferredSize(// USE TO SEPERATE THE TEXTBUTTON
          preferredSize: Size.fromHeight(48),//SIZE STARTING FROM THE END OF THE TEXTBUTTON HEIGHT
          child: Column(
            children: [
              Container(height: 16, color: Colors.white,),
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  // indicatorColor: Colors.black,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(child: SizedBox(width: 300, child: Center(child: Text("Pending")))),
                    Tab(child: SizedBox(width: 300, child: Center(child: Text("Completed"),),),),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
      body: Container(
        color: Color(0xFFF5F2EA),
        child: TabBarView(
          controller: _tabController,
          children: [
            _pendingBookings(),
            _completedBookings(),
          ],
        ),
      ),
    );
  }

  Widget _pendingCard({
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
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16,),
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
                  Text(type),
                  Text(checkIn),
                  Text(checkOut),
                  SizedBox(height: 4,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: status.toLowerCase() == "pending" ? Colors.red[100] : Colors.green[100],
                      border: Border.all(color: status.toLowerCase() == "pending" ? Colors.red[800]! : Colors.green[800]!),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: status.toLowerCase() == "pending" ? Colors.red[900] : Colors.green[900]
                      ),
                    ),
                  ),
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
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16,),
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
                  Text(type),
                  SizedBox(height: 4,),
                  TextButton(onPressed: detailPage,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green[400]),
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

  Widget _pendingBookings() {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        _pendingCard(
          name: "Ulin Mahoni West Jakarta",
          type: "Alpha Room",
          checkIn: "check in 15 Mar 2025",
          checkOut: "check out 17 Mar 2025",
          status: "On-going",
        ),
        _pendingCard(
          name: "Ulin Mahoni West Jakarta",
          type: "Alpha Room",
          checkIn: "check in 19 Mar 2025",
          checkOut: "check out 21 Mar 2025",
          status: "Pending",
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
}
