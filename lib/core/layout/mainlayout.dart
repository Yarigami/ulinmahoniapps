import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/core/widgets/navbar.dart';
import 'package:ulinmahoniapps/core/widgets/bottomnavbar.dart';
import '../widgets/bottomcontactbar.dart';

class MainLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final bool showBottomNav;
  final bool showNavBar;
  final bool showContactBar;
  final Color backgroundColor;

  const MainLayout({
    Key? key,
    required this.currentIndex,
    required this.child,
    this.showBottomNav = true,
    this.showNavBar = true,
    this.showContactBar = false, // <- Nilai default true
    this.backgroundColor = const Color(0xFFF5F2EA),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: showNavBar ? const Navbar(initialLanguage: 'ID') : null,
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showContactBar) BottomContactBar(), // Tambahkan bottomContactBar jika showContactBar true
          if (showBottomNav) BottomNavBar(currentIndex: currentIndex), //bottomNavBar
        ],
      ),
    );
  }
}
