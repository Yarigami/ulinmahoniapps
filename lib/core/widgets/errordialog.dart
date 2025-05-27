import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showErrorDialog(
    BuildContext context,
    String message, {
      String? routeName, // Tetap opsional untuk memungkinkan dialog tanpa tombol navigasi
      String? buttonText, // Tetap opsional
    }) {
  // Assert untuk memastikan jika routeName ada, buttonText juga ada
  // Ini akan menghasilkan error di debug mode jika salah satu tidak ada
  assert(
  (routeName == null && buttonText == null) ||
      (routeName != null && buttonText != null),
  'Jika routeName disediakan, buttonText juga harus disediakan, dan sebaliknya.',
  );

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/ulinmahonilogo.png', // Ganti dengan path gambar kamu
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text(
            'OK',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Tombol Opsional: Hanya tampilkan jika kedua parameter ada
        if (routeName != null && buttonText != null)
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Tutup dialog
              context.push(routeName);    // Navigasi ke rute
            },
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Color(0xFF005F21),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    ),
  );
}