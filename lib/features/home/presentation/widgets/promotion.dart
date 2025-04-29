import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/productcard.dart'; // Pastikan path sesuai dengan file Anda
import '../../data/promotion_data.dart';

class PromotionSection extends StatefulWidget {
  final Color? backgroundColor; // Properti backgroundColor nullable
  const PromotionSection({Key? key, this.backgroundColor}) : super(key: key);

  @override
  State<PromotionSection> createState() => _PromotionSectionState();
}

class _PromotionSectionState extends State<PromotionSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor, // Menggunakan backgroundColor tanpa nilai default
      child: Column(
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
              itemCount: promotionData.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  image: promotionData[index]['image']!,
                  title: promotionData[index]['title']!,
                  onTap: () {
                    context.push('/detailhouse');
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
