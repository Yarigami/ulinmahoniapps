import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/core/widgets/navbar.dart';
import 'package:ulinmahoniapps/core/widgets/bottomnavbar.dart';

class MainLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final bool showBottomNav;
  final bool showNavBar; // <- Tambahan variabel ini

  const MainLayout({
    super.key,
    required this.currentIndex,
    required this.child,
    this.showBottomNav = true,
    this.showNavBar = true, // <- Default true
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
      bottomNavigationBar:
      showBottomNav ? BottomNavBar(currentIndex: currentIndex) : null,
    );
  }
}
