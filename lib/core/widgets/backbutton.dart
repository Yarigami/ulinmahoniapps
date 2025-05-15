import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  final Color iconColor;
  final double iconSize;
  final String? redirectRoute; // Optional parameter

  const CustomBackButton({
    super.key,
    this.iconColor = Colors.white,
    this.iconSize = 24.0,
    this.redirectRoute, // optional
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: iconColor, size: iconSize),
      onPressed: () {
        if (redirectRoute != null) {
          context.go(redirectRoute!); // Navigate to specific route
        } else {
          context.pop(); // Default behavior
        }
      },
    );
  }
}
