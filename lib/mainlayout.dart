import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/presentation/widgets/bottomnavbar.dart';

class MainLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;

  const MainLayout({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex),
    );
  }
}
