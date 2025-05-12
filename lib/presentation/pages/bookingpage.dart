import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:ulinmahoniapps/listData.dart';
import 'bookingdetail.dart';
// import 'package:ulinmahoniapps/profile/profile_page.dart';
//api
import 'package:ulinmahoniapps/api/api_service.dart';
import 'package:ulinmahoniapps/api/transaction_model.dart';

class Bookingpage extends StatefulWidget {
  // final List<ListData> data;
  const Bookingpage({super.key});

  @override
  State<Bookingpage> createState() => _BookingpageState();
}

class _BookingpageState extends State<Bookingpage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  late Future<List<Transaction>> transactions;

  // DATA TEST
  // final String image = "assets/images/house.png";
  // final String name = "Ulin Mahoni West Jakarta";
  // final String type = "Alpha Room";
  // final DateTime checkIn = DateTime(2025, 3, 7);
  // final DateTime checkOut = DateTime(2025, 3, 10);
  // final double hpm = 200000;
  // final int duration = 3;
  // final double discount = 0.1;
  // late double total = hpm * duration;
  // late double ftotal = 540000;

  //DATA TEST
  // final List<Map<String, dynamic>> _upcomingList =[
  // {
  //   "image": "assets/images/house.png",
  //   "name": "Ulin Mahoni West Jakarta",
  //   "type": "Alpha Room",
  //   "checkIn": DateTime(2025, 3, 15),
  //   "checkOut": DateTime(2025, 3, 17),
  //   "status": "On-going",
  // },
  // {
  //   "image": "assets/images/house.png",
  //   "name": "Ulin Mahoni West Jakarta",
  //   "type": "Alpha Room",
  //   "checkIn": DateTime(2025, 3, 19),
  //   "checkOut": DateTime(2025, 3, 21),
  //   "status": "Waiting",
  // },
  // {
  //   "image": "assets/images/house.png",
  //   "name": "Ulin Mahoni West Jakarta",
  //   "type": "Alpha Room",
  //   "checkIn": DateTime(2025, 3, 25),
  //   "checkOut": DateTime(2025, 3, 28),
  //   "status": "Upcoming",
  // }
  // ];

  // late List<Map<String, dynamic>> _upcomingList = [];
  // late List<Map<String, dynamic>> _completedList = []; //= [
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
  late List<Map<String, dynamic>> _upcomingList = [];
  late List<Map<String, dynamic>> _completedList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    transactions = ApiService().fetchTransactions();
    // API
    transactions.then((transaction){
      setState(() {
        _upcomingList = transaction.map((tr) => {
          "image": "assets/images/ulinhouse.jpg",
          "name": tr.propertyName ?? "-",
          "type": tr.propertyType  ?? "-",
          "checkIn": tr.checkIn,
          "checkOut": tr.checkOut,
          "status": tr.status,
          "trStatus": tr.transactionStatus,
          "orderId": tr.orderId,
          "trDate": tr.transactionDate,
          "trType": tr.transactionType,
          "roomName": tr.roomName,
          "hpm": tr.dailyPrice,
          "roomPrice": tr.roomPrice,
          "adminFees": tr.adminFees,
          "grandTotal": tr.grandTotalPrice,
          // "hpm": tr.dailyPrice ?? 0.0,
          // "duration": tr.bookingDays ?? 0.0,
          // "total": tr.grandTotalPrice ?? 0.0,
        }).toList();
        _completedList = transaction.map((tr) => {
          // Descriptive info first
          "name": tr.propertyName ?? "-",
          "type": tr.propertyType ?? "-",
          "image": "assets/images/ulinhouse.jpg",
          "roomName": tr.roomName,

          // Pricing and numeric values
          "hpm": tr.dailyPrice ?? 0.0,
          "roomPrice": tr.roomPrice,
          "adminFees": tr.adminFees,
          "duration": tr.bookingDays ?? 0.0,
          "grandTotal": tr.grandTotalPrice ?? 0.0,

          // Date and status info
          "checkIn": tr.checkIn,
          "checkOut": tr.checkOut,
          "status": tr.status,
          "trStatus": tr.transactionStatus,
          "orderId": tr.orderId,
          "trDate": tr.transactionDate,
          "trType": tr.transactionType,

          // "discount" =
          // "ftotal" =
        }).toList();
      });
    });

    _sortUpcoming();
    _sortCompleted();
    // COMPLETED LIST TESTING
    // _completedList = //List<Map<String, dynamic>>.from(widget.data);
    // [
    //   ...widget.data.map((data) => data.toMap()),
    //   {
    //     "image": image,
    //     "name": name,
    //     "type": type,
    //     "checkIn": checkIn,
    //     "checkOut": checkOut,
    //     "hpm": hpm,
    //     "duration": duration,
    //     "total": total,
    //     "discount": discount,
    //     "ftotal": ftotal
    //   },
    //   {
    //     "image": "assets/images/house.png",
    //     "name": "Ulin Mahoni East Jakarta",
    //     "type": "Beta Room",
    //     "checkIn": DateTime(2025, 3, 3),
    //     "checkOut": DateTime(2025, 3, 5),
    //     "hpm": 300000,
    //     "duration": 3,
    //     "total": 900000,
    //     "discount": 0,
    //     "ftotal": 900000
    //   }
    // ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void detailPage(Map<String, dynamic> booking){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bookingdetail(booking: booking)));
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
    if (booking['status'] == '0' || booking['trStatus'] == 'completed'){
      return SizedBox.shrink();
    }
    else{
      return Card(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 4),
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/images/ulinhouse.jpg",
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
                                color: booking['trStatus'].toLowerCase() == "upcoming" ? Colors.red[100]
                                    : booking['trStatus'].toLowerCase() == "waiting" ? Colors.yellow[100] : Colors.green[100],
                                border: Border.all(color: booking['trStatus'].toLowerCase() == "upcoming" ? Colors.red[800]!
                                    : booking['trStatus'].toLowerCase() == "waiting" ? Colors.yellow[800]! : Colors.green[800]!),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                booking['trStatus'] == "upcoming" ? "Upcoming" : booking['trStatus'] == "active" ? "On-going" :
                                booking['trStatus'] == "waiting" ? "Waiting" : "not detected",
                                style: TextStyle(
                                    color: booking['trStatus'].toLowerCase() == "upcoming" ? Colors.red[900]
                                        : booking['trStatus'].toLowerCase() == "waiting" ? Colors.yellow[900] : Colors.green[900],
                                    fontSize: 10
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: Text("Check-in: ${formattedDate(booking['checkIn'])}"),
                        // child: Text("Check-in: ${booking['checkIn']}"), // API
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: Text("Check-out: ${formattedDate(booking['checkOut'])}"),
                        // child: Text("Check-out: ${booking['checkOut']}"), // API
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
  }

  Widget _completedCard({required Map<String, dynamic> booking}) {
    if (booking['status'] == '0' || booking['trStatus'] != 'completed'){
      return SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.circular(12),
              child: Image.asset("assets/images/ulinhouse.jpg",
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
                      // child: Text("Check-out: ${formattedDate(booking['checkOut'])}"),
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
    if (_completedList.isEmpty){
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: _completedList.length,
      itemBuilder: (context, index){
        return _completedCard(booking: _completedList[index]
        );
      },
    );
  }

  String formattedDate(dynamic date){
    if (date == null){
      return "no date";
    }
    else if(date is String){
      return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
    }
    else if(date is DateTime) {
      return DateFormat('dd MMM yyyy').format(date);
    }
    else {
      return "-";
    }
  }
}
