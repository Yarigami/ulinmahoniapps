import 'package:flutter/material.dart';
import 'booking/my_booking.dart';
import 'smart_controller.dart';
import 'smart_home.dart';
import 'profile/my_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky Navbar App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0; // START IN HOME
  final List<Widget> _pages = [
    Center(child: Text("Home", style: TextStyle(fontSize: 24))),
    MyBooking(),
    // SmartHome(),
    Center(child: Text("UMI", style: TextStyle(fontSize: 24))),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "My Booking"),
          // BottomNavigationBarItem(icon: Icon(Icons.home_work), label: "Smart Home"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "UMI"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile"),
        ],
      ),
    );
  }
}
