import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/productcard.dart';
import '../../provider/property_provider.dart';
import '../../../../core/widgets/formatcurrency.dart';

class PromotionSection extends ConsumerWidget {
  final Color? backgroundColor;
  final String selectedFilterLabel;
  const PromotionSection({Key? key, this.backgroundColor, required this.selectedFilterLabel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertiesAsync = ref.watch(propertiesProvider(selectedFilterLabel));

    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "PROMOTION",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),

          propertiesAsync.when(
            data: (propertyList) {
              final promoProperties = propertyList
                  .where((property) =>
              property.status == 1 &&
                  (property.priceDiscountedDaily != null || property.priceDiscountedMonthly != null))
                  .toList();

              if (promoProperties.isEmpty) {
                return const Center(child: Text('Tidak ada promo saat ini.'));
              }

              return SizedBox(
                height: 325,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: promoProperties.length,
                  itemBuilder: (context, index) {
                    final property = promoProperties[index];
                    final promoPrice = property.priceDiscountedDaily ?? property.priceDiscountedMonthly;
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(
                        image: 'assets/images/ulinhouse.jpg', // Replace with property.imageUrl if available
                        title: property.name,
                        location: property.location,
                        detail: property.distance,
                        price: 'Promo ${formatCurrency(promoPrice!)}/hari',
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
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}
