import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/productcard.dart';
import '../../data/populararea_data.dart';

class AreaPopularSection extends StatefulWidget {
  final Color? backgroundColor; // Properti backgroundColor nullable
  const AreaPopularSection({Key? key, this.backgroundColor}) : super(key: key);

  @override
  State<AreaPopularSection> createState() => _AreaPopularSectionState();
}

class _AreaPopularSectionState extends State<AreaPopularSection> {
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
              "AREA TERPOPULER",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 300, // Sesuaikan dengan tinggi yang diinginkan
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: areaPopularData.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  image: areaPopularData[index]['image']!,
                  title: areaPopularData[index]['title']!,
                  onTap: () {
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
