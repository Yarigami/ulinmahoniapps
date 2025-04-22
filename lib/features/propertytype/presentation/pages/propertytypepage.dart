import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/propertytype_data.dart';
import '../widgets/propertyitem.dart';
import '../../../../core/widgets/backbutton.dart';
import '../../../../core/layout/mainlayout.dart';

class PropertyTypePage extends StatelessWidget {
  const PropertyTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      backgroundColor: const Color(0xFFF5F2EA),
      showBottomNav: false,
      showNavBar: false,
      child: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Property Type',
              leading: CustomBackButton(iconColor: Colors.white),
            ),
            Expanded(
              child: PropertyTypeList(categories: categories),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.title, this.leading})
      : super(key: key);

  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF005F21),
      ),
      child: Row(
        children: [
          if (leading != null) leading!,
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyTypeList extends StatelessWidget {
  const PropertyTypeList({Key? key, required this.categories})
      : super(key: key);

  final List<Map<String, String>> categories; // <- Deklarasikan categories sebagai properti kelas

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return PropertyItem(
          title: category['title']!,
          image: category['image']!,
          onTap: () {
            final route = category['route'] ?? '/comingsoon';
            context.push(route);
          },
        );
      },
    );
  }
}
