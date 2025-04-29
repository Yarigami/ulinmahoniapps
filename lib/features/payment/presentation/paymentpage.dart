import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/core/layout/mainlayout.dart';
import 'package:ulinmahoniapps/core/widgets/backbutton.dart';
import '../data/payment_data.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      showBottomNav: false,
      child: Scaffold(
        backgroundColor: Color(0xFF333333),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian Atas (Gambar dan Informasi)
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(roomData['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: CustomBackButton(), // Menggunakan CustomBackButton
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roomData['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                         roomData['type'] ?? '',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Informasi Tambahan dan Rincian Harga
              Container(
                margin: EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            roomData['location'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        roomData['name'],
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Check-In'),
                          Text(roomData['checkIn']),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Check-Out'),
                          Text(roomData['checkOut']),
                        ],
                      ),
                      SizedBox(height: 24),
                      // Data Pemesan
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email, color: Colors.grey),
                                SizedBox(width: 8),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.grey),
                                    children: [
                                      TextSpan(text: 'Isi Data Pemesan '),
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.add, color: Colors.grey),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Metode Pembayaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Column(
                        children: paymentMethods.map((method) => PaymentMethodItem(
                          icon: method['icon'],
                          text: method['text'],
                        )).toList(),
                      ),
                      SizedBox(height: 24),
                      // Rincian Harga
                      Text(
                        'Rincian Harga',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Iterasi Item Details
                      Column(
                        children: itemDetails.asMap().entries.map((entry) {
                          int idx = entry.key;
                          Map<String, dynamic> item = entry.value;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('(${idx + 1}) ${item['name']}'),
                              Text('Rp ${item['price']}'),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Pajak dan Biaya'),
                          Text('Rp 10.369'), // Nilai pajak tetap
                        ],
                      ),
                      Divider(height: 32, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Harga',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp ${calculateTotalPrice(itemDetails)}', // Menghitung total harga
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      // Tombol Bayar
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Tambahkan logika pembayaran di sini
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF005F21),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Bayar Sekarang'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menghitung total harga
  String calculateTotalPrice(List<Map<String, dynamic>> items) {
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += double.parse(item['price']);
    }
    totalPrice += 10.369; // Tambahkan pajak tetap
    return totalPrice.toStringAsFixed(3); // Format menjadi 3 desimal
  }
}

class PaymentMethodItem extends StatefulWidget {
  final IconData icon;
  final String text;

  const PaymentMethodItem({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  _PaymentMethodItemState createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: Colors.grey),
              SizedBox(width: 8),
              Text(widget.text),
            ],
          ),
          Icon(Icons.check_box_outline_blank, color: Colors.grey),
        ],
      ),
    );
  }
}
