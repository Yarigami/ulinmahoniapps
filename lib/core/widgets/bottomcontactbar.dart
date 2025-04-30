import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Inisialisasi warna menggunakan kode hex
const Color firebrickColor = Color(0xFFB22222);
const Color forestGreenColor = Color(0xFF005F21);

class BottomContactBar extends StatelessWidget {
  // Fungsi untuk membuka WhatsApp atau fallback ke browser
  void _launchWhatsApp(BuildContext context) async {
    final phone = '6285694608028';
    final message = Uri.encodeComponent('Halo, saya tertarik');
    final url = 'https://wa.me/$phone?text=$message';

    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak bisa membuka WhatsApp.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
      child: Row(
        children: [
          // Bagian harga dan promo
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Harga Mulai Dari",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Rp ",
                        style: TextStyle(
                          color: firebrickColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: "200.000",
                        style: TextStyle(
                          color: firebrickColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: " / Hari",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
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
                      Icon(Icons.local_offer, color: forestGreenColor, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "Diskon Sewa 1 bulan",
                        style: TextStyle(
                          color: forestGreenColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12),

          // Tombol WhatsApp
          ElevatedButton(
            onPressed: () => _launchWhatsApp(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: forestGreenColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.phone, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  "Hubungi Kami",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
