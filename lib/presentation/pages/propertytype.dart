import 'package:flutter/material.dart';

class BrowseAllPage extends StatelessWidget {
  const BrowseAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse All')),
      body: const Center(child: Text('Semua hunian ditampilkan di sini')),
    );
  }
}
