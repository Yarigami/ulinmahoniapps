import 'package:flutter/material.dart';

Widget inputField(String hint,TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[200], // Match Register Page
      borderRadius: BorderRadius.circular(8), // Match Register Page
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Match Register Page
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    ),
  );
}