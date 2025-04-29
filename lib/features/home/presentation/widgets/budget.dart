import 'package:flutter/material.dart';
import '../../../../core/widgets/productcard.dart';
import 'package:go_router/go_router.dart';
import '../../data/budget_data.dart';

class BudgetSection extends StatefulWidget {
  final Color? backgroundColor; // Properti backgroundColor nullable
  const BudgetSection({Key? key, this.backgroundColor}) : super(key: key);

  @override
  State<BudgetSection> createState() => _BudgetSectionState();
}

class _BudgetSectionState extends State<BudgetSection> {
  int _selectedBudgetIndex = 0;
  final List<String> _budgetOptions = ['< 1 Juta', '1 - 2 Juta', '> 2 Juta'];

  final darkGreen = const Color(0xFF184D37);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor, // Menggunakan backgroundColor tanpa nilai default
      child: Padding(
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
                itemCount: budgetItems.length,
                itemBuilder: (context, index) {
                  final item = budgetItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ProductCard(
                      image: item['image']!,
                      title: item['title']!,
                      onTap: () {
                        context.push('/detailhouse');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
