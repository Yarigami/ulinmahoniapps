import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/features/home/data/filtertype_data.dart';

class FilterTypeBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTypeSelected;
  final Color selectedColor;
  final Color unselectedColor;

  const FilterTypeBar({
    super.key,
    required this.selectedIndex,
    required this.onTypeSelected,
    this.selectedColor = const Color(0xFF004D40), // darkGreen
    this.unselectedColor = const Color(0xFF800000), // maroon
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: List.generate(subCategories.length, (index) {
          final isSelected = selectedIndex == index;
          final color = isSelected ? selectedColor : unselectedColor;
          final icon = subCategories[index]['icon'] as IconData;
          final label = subCategories[index]['label'] as String;

          return GestureDetector(
            onTap: () => onTypeSelected(index),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 20, color: color),
                  const SizedBox(height: 4),
                  Text(label, style: TextStyle(fontSize: 12, color: color)),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 20,
                      color: color,
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
