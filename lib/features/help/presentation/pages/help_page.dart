import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ulinmahoniapps/core/widgets/appbar.dart';
import '../../../../core/layout/mainlayout.dart';
import '../widgets/contacus.dart';
import '../widgets/faq.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: "Help Center"),
        body: Column( // Menggunakan Column untuk memisahkan TabBar dan TabBarView
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF134E3A), // Warna indikator
              labelColor: const Color(0xFF134E3A), // Warna teks tab yang dipilih
              unselectedLabelColor: Colors.grey, // Warna teks tab yang tidak dipilih
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "FAQ"), // Tetap menggunakan FAQ karena sudah umum
                Tab(text: "Hubungi Kami"), // Diubah ke Bahasa Indonesia
              ],
            ),
            Expanded( // Menggunakan Expanded agar TabBarView mengisi sisa ruang
              child: TabBarView(
                controller: _tabController,
                children: [
                  faq(),
                  help(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
