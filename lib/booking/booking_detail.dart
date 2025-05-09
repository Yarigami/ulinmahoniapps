import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'my_booking.dart';
import 'package:ulinmahoniapps/profile/profile_page.dart';
import 'package:ulinmahoniapps/main.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ulinmahoniapps/api/api_service.dart';
import 'package:ulinmahoniapps/api/transaction_model.dart';

class BookingDetail extends StatefulWidget {
  final Map<String, dynamic> booking;
  const BookingDetail({super.key, required this.booking});

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  int _currentIndex = 1;
  late Future<List<Transaction>> transactions;
  // late List<Map<String, dynamic>> _historyList;

  // @override
  // void initState(){
  //   super.initState();
  //   transactions = ApiService().fetchTransactions();
  //   transactions.then((history){
  //     setState(() {
  //       _historyList = history.map((hist) => {
  //         "image": "assets/images/house.png",
  //         "name": hist.propertyName,
  //         "type": hist.propertyType,
  //         "checkIn": hist.checkIn,
  //         "checkOut": hist.checkOut,
  //         "hpm": hist.dailyPrice,
  //         "duration": hist.bookingDays,
  //         "total": hist.grandTotalPrice,
  //         // "discount" =
  //         // "ftotal" =
  //       }).toList();
  //     });
  //   });
  // }

  void myBooking(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.booking["name"], style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFFd2c8ae),
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFd2c8ae), Color(0xFFF5F2EA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          )
        ),
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.asset(
              "assets/images/house.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            // margin: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF5F2EA), Color(0xFFF5F2EA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: Icon(Icons.apartment),),
                _info("Nama:", widget.booking["name"]),
                _info("Jenis Ruangan:", widget.booking["type"]),
                // _info("Check-in:", formattedDate(widget.booking["checkIn"])),
                _info("Check-in:", formattedDate(DateTime.parse(widget.booking["checkIn"]))),
                // _info("Check-out:", formattedDate(widget.booking["checkOut"])),
                _info("Check-out:", formattedDate(DateTime.parse(widget.booking["checkOut"]))),
                Divider(height: 20, color: Colors.black,),
                // _info("Harga Per Malam:", formatRP(widget.booking["hpm"])),
                _info("Harga Per Malam:", widget.booking["hpm"]),
                _info("Jumlah Malam:", widget.booking["duration"]),
                // _info("Harga Total:", formatRP(widget.booking["total"]), labelColor: Colors.green),
                _info("Harga Total:", widget.booking["total"], labelColor: Colors.green),
                // _info("Diskon:", formatRP(widget.booking["discount"])),
                _info("Diskon:", widget.booking["discount"]),
                Divider(height: 20, color: Colors.black,),
                // _info("Harga Terakhir:", formatRP(widget.booking["ftotal"]), isBold: true, labelColor: Color(0xFF0d9488),),
                _info("Harga Terakhir:", widget.booking["ftotal"], isBold: true, labelColor: Color(0xFF0d9488),),
                SizedBox(height: 16,),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.red,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 0){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainHomePage())
              );
            }
            else if (index == 2){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainHomePage())
              );
            }
            else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage())
              );
            }
          },
          // onPressed: () {
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => MainHomePage()),
          //         (route) => false,
          //   );
          // },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "My Booking"),
            // BottomNavigationBarItem(icon: Icon(Icons.home_work), label: "Smart Home"),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "UMI"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile"),
          ],
        ),
      ),
    );
  }

  String formatRP(dynamic num){
    if (num == null){
      return "-";
    }
    final formatted = NumberFormat.currency(locale: 'id_ID', symbol: 'RP. ', decimalDigits: 0);
    return formatted.format(num);
  }

  Widget _info(String label, dynamic value, {bool isBold = false, Color? labelColor}){
    String display;
    if (value == null){
      display = '-';
    }
    else if (value is DateTime){
      display = DateFormat('dd MMMM yyyy').format(value);
    }
    else{
      display = value.toString();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold? FontWeight.bold : FontWeight.normal,
            color: labelColor ?? Colors.black,
          ),
        ),
        Text(
          display,
          style: TextStyle(
            fontWeight: isBold? FontWeight.bold : FontWeight.normal,
            color: labelColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
  String formattedDate(DateTime date){
    return DateFormat('EEEE, dd MMMM yyyy').format(date);
  }
}

