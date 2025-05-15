import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gambar/logo di atas
          Image.asset(
            'assets/images/ulinmahonilogo.png', // Ganti dengan path gambar kamu
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 16),

          // Pesan Error
          Text(
            message,
            style: TextStyle(
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
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.black, // Warna teks hitam
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}