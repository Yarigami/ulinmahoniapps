import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/booking');
        break;
      case 2:
        context.go('/smart-home');
        break;
      case 3:
        context.go('/umi');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xFF800000);
    const darkGreen = Color(0xFF184D37);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: darkGreen,
      unselectedItemColor: maroon,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'My Booking',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.houseSignal),
          label: 'Smart Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sensor_door),
          label: 'UMI',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
