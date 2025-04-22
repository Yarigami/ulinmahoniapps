import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  final Color iconColor;
  final double iconSize;

  const CustomBackButton({
    super.key,
    this.iconColor = Colors.white,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: iconColor, size: iconSize),
      onPressed: () {
        context.pop();
      },
    );
  }
}
