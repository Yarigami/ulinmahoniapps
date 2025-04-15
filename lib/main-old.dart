import 'package:flutter/material.dart';
import 'smart_controller.dart';
import 'my_booking.dart';

void main() => runApp(MaterialApp(
  home: MyBooking(),
));

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int _currentIndex = 1;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  void _onTap(index){
    setState(() {
      _currentIndex = index;
    });

    switch (index){
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SmartHome()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            onPressed: (){},
            child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        backgroundColor: Colors.green.shade700,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Pending",),
            Tab(text: "Completed",),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _pendingBookings(),
          _completedBookings(),
          // Center(child: Text("Pending")),
          // Center(child: Text("Completed")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.red,
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "My Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.home_work), label: "Smart Home"),
          BottomNavigationBarItem(icon: Icon(Icons.location_city), label: "UMI"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile"),
        ],
      ),
    );
  }

  Widget _pendingCard({
    required String name,
    required String type,
    required String checkIn,
    required String checkOut,
    required String status,
  }){
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12), // Add spacing around image and text
        minVerticalPadding: 16, // Increase vertical padding to give more height
        leading: SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(
            "assets/images/placeholder.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(type),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: status.toLowerCase() == "pending" ? Colors.red[100] : Colors.green[100],
                border: Border.all(color: status.toLowerCase() == "pending" ? Colors.red[800]! : Colors.green[800]!),
                // color: Colors.green[100],
                // border: Border.all(color: Colors.green[800]!),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "$status",
                style: TextStyle(
                    color: status.toLowerCase() == "pending" ? Colors.red[900] : Colors.green[900]
                  // color: Colors.green[900],
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(checkIn),
            Text(checkOut),
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
  }){
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12), // Add spacing around image and text
        minVerticalPadding: 16, // Increase vertical padding to give more height
        leading: SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(
            "assets/images/placeholder.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(type),
            SizedBox(height: 6),
            SizedBox(height: 6),
            Text(checkIn),
            Text(checkOut),
          ],
        ),
      ),
    );
  }

  Widget _pendingBookings(){
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

  Widget _completedBookings(){
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

