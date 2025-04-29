import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/productcard.dart';
import '../../../../core/widgets/backbutton.dart';
import '../../data/housing_data.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key});

  @override
  State<HousingPage> createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container( // Bungkus dengan Container
              decoration: const BoxDecoration( // Atur dekorasi
                color: Color(0xFF005F21), // Warna latar belakang hijau gelap
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CustomBackButton(iconColor: Colors.white,),
                  const SizedBox(width: 8),
                  const Text(
                    'Housing',
                    style: TextStyle( // Atur style untuk teks
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white, // Warna teks putih
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
