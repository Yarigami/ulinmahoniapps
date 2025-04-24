import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.push('/home');
        break;
      case 1:
        context.push('/mybooking');
        break;
      case 2:
        context.push('/comingsoon');
        break;
      case 3:
        context.push('/comingsoon');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xFF800000);
    const darkGreen = Color(0xFF184D37);

    final List<Map<String, dynamic>> items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.calendar_today, 'label': 'My Booking'},
      {'icon': Icons.phone, 'label': 'UM'}, // UMI diganti dengan logo telepon
      {'icon': Icons.person, 'label': 'Login'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List.generate(items.length * 2 - 1, (i) {
          // Odd index: separator
          if (i.isOdd) {
            return Container(
              width: 1,
              height: 36,
              color: Colors.grey.shade300,
            );
          }

          final index = i ~/ 2;
          final item = items[index];
          final isSelected = index == currentIndex;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3), // tambahkan padding di sini
              child: InkWell(
                onTap: () => _onTap(context, index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item['icon'],
                      color: isSelected ? darkGreen : maroon,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label'],
                      style: TextStyle(
                        color: isSelected ? darkGreen : maroon,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
