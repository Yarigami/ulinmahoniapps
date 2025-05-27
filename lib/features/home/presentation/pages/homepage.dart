import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulinmahoniapps/features/home/presentation/widgets/populararea.dart';
import 'package:ulinmahoniapps/features/home/presentation/widgets/promotion.dart';
import 'package:go_router/go_router.dart';
import '../widgets/videosearchbanner.dart';
import '../../../../core/widgets/productcard.dart';
import '../widgets/filtertype.dart';
import '../widgets/filter.dart';
import '../widgets/bestseller.dart';
import '../widgets/budget.dart';
import '../widgets/browseallbutton.dart';
import '../../provider/property_provider.dart';
import '../../../../core/widgets/formatcurrency.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedSubCategoryIndex = 0;
  int _selectedFilterTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final propertiesAsync = ref.watch(propertiesProvider);

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VideoSearchBanner(),

              Container(
                color: Colors.white,
                height: 8,
                width: double.infinity,
              ),

              Filtertype(
                selectedIndex: _selectedFilterTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedFilterTabIndex = index;
                  });
                },
              ),

              const SizedBox(height: 14),

              Filter(
                selectedIndex: _selectedSubCategoryIndex,
                onTypeSelected: (index) {
                  setState(() {
                    _selectedSubCategoryIndex = index;
                  });
                },
              ),

              const SizedBox(height: 5),

              propertiesAsync.when(
                data: (propertyList) {
                  final filteredProperties = propertyList
                      .where((property) => property.tags.toLowerCase().contains('house'))
                      .toList();
                  if (filteredProperties.isEmpty) {
                    return const Center(child: Text('No properties found.'));
                  }
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: filteredProperties.length,
                    itemBuilder: (context, index) {
                      final property = filteredProperties[index];
                      return ProductCard(
                        image: 'assets/images/ulinhouse.jpg',
                        title: property.name,
                        location: property.location,
                        detail: property.tags,
                        price: formatCurrency(property.priceOriginalDaily ?? 0),
                        onTap: () {
                          print(property);
                          print(property.idrec);
                          context.push('/detailhouse/${property.idrec}');
                        },
                      );
                    },
                  ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  print('Error: $error');
                  print('StackTrace: $stack');
                  return Center(child: Text('Error: $error'));
                },
              ),

              const BrowseAllButton(),

              const SizedBox(height: 20),

              const BestSellerSection(backgroundColor: Color(0xFFE8E3D9)),

              const PromotionSection(),

              Container(
                height: 5,
                color: const Color(0xFFECE8E1),
              ),

              const AreaPopularSection(backgroundColor: Color(0xFFECE7DE)),

              Container(
                height: 5,
                color: const Color(0xFFECE8E1),
              ),

              const BudgetSection(),
            ],
          ),
        ),
      ),
    );
  }
}
