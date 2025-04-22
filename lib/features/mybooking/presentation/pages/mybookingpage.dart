import 'package:flutter/material.dart';
import '../../data/mybooking_data.dart';
import '../widgets/mybooking_card.dart';
import '../../../../core/widgets/backbutton.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layout/mainlayout.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

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
    final filtered =
    bookings.where((b) => b['status'] == status.toLowerCase()).toList();

    return filtered
        .map(
          (b) => BookingCard(
        image: b['image']!,
        title: b['title']!,
        location: b['location']!,
        checkIn: b['checkIn']!,
        checkOut: b['checkOut']!,
        status: b['status']!,
        statusText: b['statusText']!,
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      showNavBar: false,
      showBottomNav: false,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            AppBar(
              backgroundColor: const Color(0xFF005F21),
              elevation: 0,
              leading: CustomBackButton(
                iconColor: Colors.white,
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Booking',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              centerTitle: false,
            ),
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
