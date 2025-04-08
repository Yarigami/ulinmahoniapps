import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/ulinhouse.jpg',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cari hunianmu', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Tanggal - Lokasi', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),

            _buildDropdownField(label: "Rent Type"),
            _buildDropdownField(label: "Check In"),
            _buildDropdownField(label: "Check Out"),
            _buildDropdownField(label: "Lokasi"),
            const SizedBox(height: 12),

            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Browse All"),
              ),
            ),
            const SizedBox(height: 12),

            const Text("Best Seller", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildBestSellerCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DropdownButtonFormField<String>(
        items: ['Contoh 1', 'Contoh 2'].map((e) {
          return DropdownMenuItem(value: e, child: Text(e));
        }).toList(),
        onChanged: (value) {},
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildBestSellerCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                'assets/images/ulinhouse.jpg',
                fit: BoxFit.cover,
                height: 100,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF184D37),
              height: 100,
              child: const Center(
                child: Text(
                  "ULIN HOUSE\nWEST JAKARTA",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}