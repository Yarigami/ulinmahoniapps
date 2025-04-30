import 'package:flutter/material.dart';
import 'my_booking.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({super.key});

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  void myBooking(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: TextButton(onPressed: (){},
        //     child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        backgroundColor: Colors.green.shade700,
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
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: Icon(Icons.apartment),),
                _info("Nama:", "Ulin Mahoni West Jakarta"),
                _info("Jenis Ruangan:", "Alpha Room"),
                _info("Check-in:", "Sab, 15 Mar 2025 (14:00-16:00)"),
                _info("Check-out:", "Mon, 17 Mar 2025 (12:00-13:00)"),
                Divider(height: 20, color: Colors.black,),
                _info("Harga Per Malam:", "RP. 200.000"),
                _info("Jumlah Malam:", "3"),
                _info("Harga Per Malam:", "RP. 200.000"),
                _info("Harga Total:", "RP. 600.000", labelColor: Colors.green[700]),
                _info("Diskon:", "10% (RP. 60.000)"),
                Divider(height: 20, color: Colors.black,),
                _info("Harga Terakhir:", "RP. 540.000", isBold: true, labelColor: Colors.green[800],),
                SizedBox(height: 16,),
                // TextButton(onPressed: myBooking,
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                //     foregroundColor: MaterialStateProperty.all(Colors.white),
                //   ),
                //   child: Text("Return")
                // ),
              ],
            ),
          )
        ],
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
}

