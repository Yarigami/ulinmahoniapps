import 'package:flutter/material.dart';
import '../../data/mybooking_data.dart';
import '../widgets/mybooking_card.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/layout/mainlayout.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({super.key});

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage>
    with SingleTickerProviderStateMixin {
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

  List<Widget> buildBookingList(String status) {
    final filtered = bookings.where((b) => b['status'].toLowerCase() == status.toLowerCase()).toList();

    return filtered
        .map(
          (b) => BookingCard(
        id: b['id'] as int,
        image: b['image'] as String,
        title: b['title'] as String,
        location: b['location'] as String,
        checkIn: b['checkIn'] as String,
        checkOut: b['checkOut'] as String,
        status: b['status'] as String,
        statusText: b['statusText'] as String,
        dataDetail: b,
      ),
    )
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showNavBar: false,
      showBottomNav: false,
      currentIndex: 1,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            CustomAppBar(title: "My Booking",showBackButton: false),
            Material( // Tambahkan Material widget di sini
              color: Colors.white, // Set warna latar belakang putih
              child: TabBar(
                controller: _tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  insets: EdgeInsets.symmetric(horizontal: 50.0),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
                tabs: const [
                  Tab(text: 'Pending'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    padding: const EdgeInsets.all(10),
                    children: buildBookingList("pending"),
                  ),
                  ListView(
                    padding: const EdgeInsets.all(10),
                    children: buildBookingList("completed"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
