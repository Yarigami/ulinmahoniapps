import 'package:flutter/material.dart';
import 'router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ulin Mahoni',
      theme: ThemeData(
        // Menggunakan ColorScheme untuk tema dengan warna dasar dari deepPurple
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Optional: Mengaktifkan Material 3
      ),
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      routerConfig: appRouter, // Menentukan konfigurasi router
    );
  }
}
