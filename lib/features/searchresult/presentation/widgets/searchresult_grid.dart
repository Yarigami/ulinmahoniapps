import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/productcard.dart';
import '../../data/searchresult_data.dart';

class SearchResultGrid extends StatelessWidget {
  const SearchResultGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24), // Tambahan padding bawah
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemCount: housingData.length,
        itemBuilder: (context, index) {
          final item = housingData[index];
          return ProductCard(
            image: item['image']!,
            title: item['title']!,
            location: item['location']!,
            detail: item['detail']!,
            price: item['price']!,
            badgeText: item['badgeText'],
            width: 180,
            imageHeight: 150,
            onTap: () {
              context.push('/detailhouse');
            },
          );
        },
      ),
    );
  }
}

