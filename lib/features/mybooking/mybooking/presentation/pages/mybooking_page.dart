import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../../../../../core/widgets/appbar.dart';
import '../../provider/mybooking_provider.dart';
import '../../controller/mybooking_controller.dart';

class MyBookingPage extends ConsumerStatefulWidget {
  const MyBookingPage({super.key});

  @override
  ConsumerState<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends ConsumerState<MyBookingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Pakai postFrameCallback supaya context dan ref sudah siap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(userBookingsProvider);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!checkLoginAndRedirect(context, ref)) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final bookingsAsync = ref.watch(userBookingsProvider);

    return MainLayout(
      showNavBar: false,
      showBottomNav: false,
      currentIndex: 1,
      child: Column(
        children: [
          const CustomAppBar(title: "My Booking", showBackButton: false),
          Material(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
                insets: EdgeInsets.symmetric(horizontal: 50.0),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          Expanded(
            child: bookingsAsync.when(
              data: (bookings) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(10),
                      children: buildBookingList(bookings, 'pending'),
                    ),
                    ListView(
                      padding: const EdgeInsets.all(10),
                      children: buildBookingList(bookings, 'completed'),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text("Error: $e")),
            ),
          ),
        ],
      ),
    );
  }
}
