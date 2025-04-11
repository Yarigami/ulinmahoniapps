import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/presentation/widgets/bottomnavbar.dart';

class MainLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final bool showBottomNav;

  const MainLayout({
    super.key,
    required this.currentIndex,
    required this.child,
    this.showBottomNav = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
      bottomNavigationBar: showBottomNav
          ? CustomBottomNavBar(currentIndex: currentIndex)
          : null,
    );
  }
}
