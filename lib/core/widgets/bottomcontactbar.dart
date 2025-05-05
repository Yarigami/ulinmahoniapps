import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Color firebrickColor = Color(0xFFB22222);
const Color forestGreenColor = Color(0xFF005F21);

class BottomContactBar extends StatelessWidget {
  final bool isAvailable;
  const BottomContactBar({super.key, this.isAvailable = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonHeight = screenHeight * 0.055;
    final fontSize = screenWidth * 0.04;
    final promoFontSize = screenWidth * 0.027;
    final iconSize = screenWidth * 0.055; // Ukuran logo/ikon mengikuti lebar layar

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Kiri: harga & promo
          Expanded(
            flex: 2,
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Harga Mulai Dari",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: fontSize, color: Colors.black),
                      children: const [
                        TextSpan(
                          text: "Rp ",
                          style: TextStyle(
                            color: firebrickColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "200.000",
                          style: TextStyle(
                            color: firebrickColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " / Hari",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: forestGreenColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: forestGreenColor, width: 1),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_offer, color: forestGreenColor, size: iconSize),
                        const SizedBox(width: 4),
                        Text(
                          "Diskon Sewa 1 bulan",
                          style: TextStyle(
                            color: forestGreenColor,
                            fontSize: promoFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Kanan: tombol
          SizedBox(
            width: screenWidth * 0.5,
            height: buttonHeight,
            child: ElevatedButton.icon(
              onPressed: () {
                context.push(isAvailable ? '/payment' : '/browse-all');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: forestGreenColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: Icon(
                isAvailable ? Icons.shopping_cart : Icons.house,
                color: Colors.white,
                size: iconSize,
              ),
              label: Text(
                isAvailable ? "Pesan Sekarang" : "Properti Lainnya",
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
