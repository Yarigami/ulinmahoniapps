import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/productcard.dart';
import '../../../../core/widgets/backbutton.dart';
import '../../../../core/layout/mainlayout.dart'; // pastikan path ini benar
import '../../data/searchresult_data.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 4,
      showBottomNav: false,
      showNavBar: false,
      showContactBar: true,
      pesansekarangbutton: false,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF005F21),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CustomBackButton(iconColor: Colors.white),
                  const SizedBox(width: 8),
                  const Text(
                    'Housing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
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
            ),
          ],
        ),
      ),
    );
  }
}
