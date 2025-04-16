import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/productcard.dart'; // Pastikan path sesuai dengan file Anda

class PromotionSection extends StatefulWidget {
  const PromotionSection({super.key});

  @override
  State<PromotionSection> createState() => _PromotionSectionState();
}

class _PromotionSectionState extends State<PromotionSection> {
  // Data dummy untuk Promotion, nantinya digantikan dengan API
  final List<Map<String, String>> _promotionData = [
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'PROMO ULIN HOUSE WEST JAKARTA',
    },
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'PROMO ULIN HOUSE EAST JAKARTA',
    },
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'PROMO ULIN HOUSE CENTRAL JAKARTA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "PROMOTION",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 325, // Atur tinggi sesuai desain
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _promotionData.length,
            itemBuilder: (context, index) {
              return ProductCard(
                image: _promotionData[index]['image']!,
                title: _promotionData[index]['title']!,
                onTap: () {
                  // Ganti dengan navigasi yang sesuai
                  context.push('/comingsoon');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
