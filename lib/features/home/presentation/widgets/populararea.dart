import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/productcard.dart';

class AreaPopularSection extends StatefulWidget {
  const AreaPopularSection({super.key});

  @override
  State<AreaPopularSection> createState() => _AreaPopularSectionState();
}

class _AreaPopularSectionState extends State<AreaPopularSection> {
  // Data dummy untuk Area Terpopuler yang nantinya bisa diganti dengan API
  final List<Map<String, String>> _areaPopularData = [
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'Jakarta Barat',
    },
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'Bogor',
    },
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'Bekasi',
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
            itemCount: _areaPopularData.length,
            itemBuilder: (context, index) {
              return ProductCard(
                image: _areaPopularData[index]['image']!,
                title: _areaPopularData[index]['title']!,
                onTap: () {
                  context.push('/comingsoon'); // Sesuaikan route target
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
