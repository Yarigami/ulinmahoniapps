import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'my_booking.dart';
import 'package:ulinmahoniapps/profile/profile_page.dart';
import 'package:ulinmahoniapps/main.dart';
import 'package:intl/date_symbol_data_local.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({super.key});

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  int _currentIndex = 1;

  void myBooking(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Ulin Mahoni West Jakarta", style: TextStyle(fontWeight: FontWeight.bold),),
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
                _info("Nama:", "Ulin Mahoni West Jakarta"),
                _info("Jenis Ruangan:", "Alpha Room"),
                _info("Check-in:", "${formattedDate(DateTime(2025, 3, 15))}"),
                _info("Check-out:", "${formattedDate(DateTime(2025, 3, 17))}"),
                Divider(height: 20, color: Colors.black,),
                _info("Harga Per Malam:", "RP. 200.000"),
                _info("Jumlah Malam:", "3"),
                _info("Harga Per Malam:", "RP. 200.000"),
                _info("Harga Total:", "RP. 600.000", labelColor: Colors.green),
                _info("Diskon:", "10% (RP. 60.000)"),
                Divider(height: 20, color: Colors.black,),
                _info("Harga Terakhir:", "RP. 540.000", isBold: true, labelColor: Color(0xFF0d9488),),
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

  Widget _info(String label, String value, {bool isBold = false, Color? labelColor}){
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
          value,
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

