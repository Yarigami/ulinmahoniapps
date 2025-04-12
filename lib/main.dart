import 'package:flutter/material.dart';

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

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void dispose(){
    _tabController.dispose();
    super.dispose();
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
          // Center(child: Text("Pending")),
          Center(child: Text("Completed")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.red,
        currentIndex: 1,
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
  }){
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image(image: AssetImage("assets/images/placeholder.png")),
        title: Text(name),
        subtitle: Column(
          children: [
            Text(name),
            Text(type),
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
            checkOut: "check out 17 Mar 2025"),
      ],
    );
  }
}

