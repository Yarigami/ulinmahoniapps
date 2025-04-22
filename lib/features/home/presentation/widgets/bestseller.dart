import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/productcard.dart';
import '../../data/bestseller_data.dart';

class BestSellerSection extends StatefulWidget {
  final Color? backgroundColor; // Tambahkan properti backgroundColor
  const BestSellerSection({Key? key, this.backgroundColor}) : super(key: key);

  @override
  State<BestSellerSection> createState() => _BestSellerSectionState();
}


class _BestSellerSectionState extends State<BestSellerSection> {
  // Data dummy yang nantinya akan digantikan dengan data dari API

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor, // Gunakan backgroundColor dari properti widget
      child: Column(
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
              itemCount: bestSellerData.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  image: bestSellerData[index]['image']!,
                  title: bestSellerData[index]['title']!,
                  onTap: () {
                    // Ganti dengan navigasi yang sesuai
                    context.push('/comingsoon');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
