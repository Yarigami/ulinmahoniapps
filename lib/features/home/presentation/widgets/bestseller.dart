import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/productcard.dart'; // Pastikan path sesuai dengan file Anda

class BestSellerSection extends StatefulWidget {
  const BestSellerSection({super.key});

  @override
  State<BestSellerSection> createState() => _BestSellerSectionState();
}

class _BestSellerSectionState extends State<BestSellerSection> {
  // Data dummy yang nantinya akan digantikan dengan data dari API
  final List<Map<String, String>> _bestSellerData = [
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'ULIN HOUSE WEST JAKARTA',
    },
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'ULIN HOUSE EAST JAKARTA',
    },
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'ULIN HOUSE CENTRAL JAKARTA',
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
            "BEST SELLER",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300, // Atur tinggi sesuai desain
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _bestSellerData.length,
            itemBuilder: (context, index) {
              return ProductCard(
                image: _bestSellerData[index]['image']!,
                title: _bestSellerData[index]['title']!,
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
