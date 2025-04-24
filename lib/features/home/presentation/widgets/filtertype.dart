import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/features/home/data/filtertype_data.dart';

class Filtertype extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color activeColor;
  final Color inactiveColor;

  const Filtertype({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.activeColor = const Color(0xFF004D40), // default darkGreen
    this.inactiveColor = Colors.black,
  }) : super(key: key);

  @override
  State<Filtertype> createState() => _FiltertypeState();
}

class _FiltertypeState extends State<Filtertype> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * (7 / 8);

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Container(
        width: containerWidth,
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filtertypedata.length,
          itemBuilder: (context, index) {
            final tab = filtertypedata[index];
            final isActive = widget.selectedIndex == index;

            return GestureDetector(
              onTap: () => widget.onTabSelected(index),
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
                      color: isActive ? widget.activeColor : widget.inactiveColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tab['label'],
                      style: TextStyle(
                        color: isActive ? widget.activeColor : widget.inactiveColor,
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
