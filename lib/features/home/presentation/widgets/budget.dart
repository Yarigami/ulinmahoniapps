import 'package:flutter/material.dart';
import '../widgets/productcard.dart';
import 'package:go_router/go_router.dart';

class BudgetSection extends StatefulWidget {
  const BudgetSection({super.key});

  @override
  State<BudgetSection> createState() => _BudgetSectionState();
}

class _BudgetSectionState extends State<BudgetSection> {
  int _selectedBudgetIndex = 0;
  final List<String> _budgetOptions = ['< 1 Juta', '1 - 2 Juta', '> 2 Juta'];

  final darkGreen = const Color(0xFF184D37);

  final List<Map<String, String>> _budgetItems = [
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'ULIN HOUSE WEST JAKARTA',
    },
    {
      'image': 'assets/images/ulinhouse.jpg',
      'title': 'ULIN HOUSE EAST JAKARTA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SESUAIKAN BUDGETMU',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          // Menampilkan filter budget
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: _budgetOptions.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedBudgetIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedBudgetIndex = index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? darkGreen : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        if (!isSelected)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _budgetOptions[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Menampilkan item berdasarkan budget yang dipilih dengan ProductCard
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _budgetItems.length,
              itemBuilder: (context, index) {
                final item = _budgetItems[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ProductCard(
                    image: item['image']!,
                    title: item['title']!,
                    onTap: () {
                     context.push('/comingsoon');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
