import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Inisialisasi warna menggunakan kode hex
const Color firebrickColor = Color(0xFFB22222);
const Color forestGreenColor = Color(0xFF005F21);

class BottomContactBar extends StatelessWidget {
  // Ganti dengan nomor WhatsApp Anda (dengan kode negara)
  final String whatsappNumber = '+628xxxxxxxxxx';

  // Fungsi untuk membuka WhatsApp
  _launchWhatsApp() async {
    var whatsappUrl = "whatsapp://send?phone=$whatsappNumber&text=Halo"; //pesan default
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Harga Mulai Dari",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Rp ",
                      style: TextStyle(
                        color: firebrickColor,
                        fontWeight: FontWeight.w500, // FontWeight diubah menjadi w500
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: "200.000",
                      style: TextStyle(
                        color: firebrickColor,
                        fontWeight: FontWeight.w500, // FontWeight diubah menjadi w500
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: " / Hari",
                      style: TextStyle(
                        fontWeight: FontWeight.w500, // FontWeight diubah menjadi w500
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_offer,
                      color: Colors.green,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Diskon Sewa 1 bulan",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: _launchWhatsApp, // Panggil fungsi untuk membuka WhatsApp
            icon: Icon(Icons.phone, color: Colors.white), // Ganti dengan ikon telepon
            label: Text(
              "Hubungi Kami",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: forestGreenColor, // Warna forestGreen yang diperbarui
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
