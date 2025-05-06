import 'package:flutter/material.dart';
import '../../data/payment_data.dart';

class PaymentSummary extends StatelessWidget {
  final List<Map<String, dynamic>> itemDetails;

  const PaymentSummary({Key? key, required this.itemDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = _calculateTotalPrice(itemDetails);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rincian Harga',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Rp ${totalPrice.toStringAsFixed(3)}', // Menghitung total harga
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
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.925,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Tambahkan logika pembayaran di sini
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005F21),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart, size: 24, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Bayar Sekarang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menghitung total harga
  double _calculateTotalPrice(List<Map<String, dynamic>> items) {
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += double.parse(item['price']);
    }
    totalPrice += 10.369; // Tambahkan pajak tetap
    return totalPrice;
  }
}
