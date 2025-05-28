import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/productcard.dart';
import 'package:go_router/go_router.dart';
import '../../provider/property_provider.dart';
import '../../../../core/widgets/formatcurrency.dart';

class BudgetSection extends ConsumerStatefulWidget {
  final Color? backgroundColor;
  final String selectedFilterLabel;
  const BudgetSection({Key? key, this.backgroundColor, required this.selectedFilterLabel}) : super(key: key);

  @override
  ConsumerState<BudgetSection> createState() => _BudgetSectionState();
}

class _BudgetSectionState extends ConsumerState<BudgetSection> {
  int _selectedBudgetIndex = 0;
  final List<String> _budgetOptions = ['< 1 Juta', '1 - 2 Juta', '> 2 Juta'];
  final darkGreen = const Color(0xFF184D37);

  @override
  Widget build(BuildContext context) {
    final propertiesAsync = ref.watch(propertiesProvider(widget.selectedFilterLabel)); // Fetch all properties

    return Container(
      color: widget.backgroundColor,
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

            // Budget filter buttons
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _budgetOptions.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedBudgetIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBudgetIndex = index;
                      });
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

            // Display filtered properties
            propertiesAsync.when(
              data: (propertyList) {
                final activeProperties = propertyList
                    .where((p) => p.status == 1 && p.priceOriginalDaily != null)
                    .toList();

                List filteredProperties = activeProperties.where((property) {
                  final price = double.parse(property.priceOriginalDaily!);
                  switch (_selectedBudgetIndex) {
                    case 0:
                      return price < 1000000;
                    case 1:
                      return price >= 1000000 && price <= 2000000;
                    case 2:
                      return price > 2000000;
                    default:
                      return true;
                  }
                }).toList();

                if (filteredProperties.isEmpty) {
                  return const Center(child: Text('Tidak ada properti untuk budget ini.'));
                }

                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredProperties.length,
                    itemBuilder: (context, index) {
                      final property = filteredProperties[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ProductCard(
                          image: 'assets/images/ulinhouse.jpg', // Replace with property.imageUrl if available
                          title: property.name,
                          location: property.location,
                          detail: property.distance,
                          price: 'Mulai dari ${formatCurrency(property.priceOriginalDaily ?? 0)}/hari',
                          onTap: () {
                            context.push('/detailhouse/${property.idrec}');
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ],
        ),
      ),
    );
  }
}
