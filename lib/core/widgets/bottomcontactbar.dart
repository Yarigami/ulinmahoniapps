import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Inisialisasi warna menggunakan kode hex
const Color firebrickColor = Color(0xFFB22222);
const Color forestGreenColor = Color(0xFF005F21);

class BottomContactBar extends StatelessWidget {
  // Ganti dengan nomor WhatsApp Anda (dengan kode negara)
  final String whatsappNumber = '+6285694608028';

  // Fungsi untuk membuka WhatsApp
  _launchWhatsApp(BuildContext context) async {
    var whatsappUrl = "whatsapp://send?phone=$whatsappNumber&text=Halo"; //pesan default
    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } else {
        // Menampilkan pesan error jika WhatsApp tidak dapat dibuka
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('WhatsApp tidak dapat dibuka. Pastikan aplikasi terpasang.'),
          ),
        );
      }
    } catch (e) {
      // Menampilkan pesan error jika terjadi kesalahan lain
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: ${e.toString()}'),
        ),
      );
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
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: "200.000",
                      style: TextStyle(
                        color: firebrickColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: " / Hari",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: forestGreenColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: forestGreenColor, width: 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_offer,
                      color: forestGreenColor,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Diskon Sewa 1 bulan",
                      style: TextStyle(
                        color: forestGreenColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton.icon(
                onPressed: () => _launchWhatsApp(context), // Panggil fungsi untuk membuka WhatsApp dengan context
                icon: Icon(Icons.phone, color: Colors.white),
                label: Text(
                  "Hubungi Kami",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: forestGreenColor,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
