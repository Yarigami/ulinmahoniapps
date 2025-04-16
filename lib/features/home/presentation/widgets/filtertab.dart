import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/features/home/data/filtertabs_data.dart';

class FilterTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color activeColor;
  final Color inactiveColor;

  const FilterTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.activeColor = const Color(0xFF004D40), // default darkGreen
    this.inactiveColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filterTabs.length,
          itemBuilder: (context, index) {
            final tab = filterTabs[index];
            final isActive = selectedIndex == index;

            return GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isActive ? Color(0xFFF5F2EA) : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      tab['icon'],
                      size: 16,
                      color: isActive ? activeColor : inactiveColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tab['label'],
                      style: TextStyle(
                        color: isActive ? activeColor : inactiveColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
