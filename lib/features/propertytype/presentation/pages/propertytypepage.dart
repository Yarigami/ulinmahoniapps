import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/propertytypelist.dart';
import '../../../../core/layout/mainlayout.dart';
import '../../../../core/widgets/appbar.dart';

class PropertyTypePage extends StatelessWidget {
  const PropertyTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      backgroundColor: const Color(0xFFF5F2EA),
      showBottomNav: false,
      showNavBar: false,
      showContactBar: true,
      pesansekarangbutton: false,
      child: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Property Type',
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