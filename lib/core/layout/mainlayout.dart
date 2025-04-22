import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/core/widgets/navbar.dart';
import 'package:ulinmahoniapps/core/widgets/bottomnavbar.dart';

class MainLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final bool showBottomNav;
  final bool showNavBar;
  final Color backgroundColor; // <- Tambahkan properti ini

  const MainLayout({
    Key? key,
    required this.currentIndex,
    required this.child,
    this.showBottomNav = true,
    this.showNavBar = true,
    this.backgroundColor = const Color(0xFFF5F2EA), // <- Nilai default
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // <- Gunakan properti backgroundColor
      appBar: showNavBar ? const Navbar(initialLanguage: 'ID') : null,
      body: child,
      bottomNavigationBar:
      showBottomNav ? BottomNavBar(currentIndex: currentIndex) : null,
    );
  }
}
