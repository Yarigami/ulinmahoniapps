import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/features/home/presentation/widgets/populararea.dart';
import 'package:ulinmahoniapps/features/home/presentation/widgets/promotion.dart';
import 'package:go_router/go_router.dart';
import '../widgets/VideoSearchBanner.dart';
import '../../../../core/widgets/productcard.dart';
import '../widgets/filtertab.dart';
import '../widgets/filtertype.dart';
import '../widgets/bestseller.dart';
import '../widgets/budget.dart';
import '../widgets/browseallbutton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedSubCategoryIndex = 0;
  int _selectedFilterTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Panggil VideoSearchBanner yang sudah dipisah
              const VideoSearchBanner(),

              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 8,
                  width: double.infinity,
                ),
              ),

              FilterTabBar(
                selectedIndex: _selectedFilterTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedFilterTabIndex = index;
                  });
                },
              ),

              const SizedBox(height: 14),

              FilterTypeBar(
                selectedIndex: _selectedSubCategoryIndex,
                onTypeSelected: (index) {
                  setState(() {
                    _selectedSubCategoryIndex = index;
                  });
                },
              ),

              const SizedBox(height: 5),

              SizedBox(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ProductCard(
                        image: 'assets/images/ulinhouse.jpg',
                        title: 'Jelambar',
                        onTap: () {
                          context.push('/comingsoon');
                        }
                    ),
                    SizedBox(width: 16),
                    ProductCard(
                        image: 'assets/images/ulinhouse.jpg',
                        title: 'Jelambar',
                        onTap: () {
                          context.push('/comingsoon');
                        }
                    ),
                    SizedBox(width: 16),
                    ProductCard(
                        image: 'assets/images/ulinhouse.jpg',
                        title: 'Jelambar',
                        onTap: () {
                          context.push('/comingsoon');
                        }
                    ),
                  ],
                ),
              ),

              BrowseAllButton(),

              SizedBox(
                height: 20,
              ),

              Container(
                height: 5,
                color: Color(0xFFECE8E1), // Ganti dengan warna yang diinginkan
              ),

              BestSellerSection(backgroundColor: Color(0xFFE8E3D9),),

              Container(
                height: 5,
                color: Color(0xFFECE8E1), // Ganti dengan warna yang diinginkan
              ),

              PromotionSection(),

              Container(
                height: 5,
                color: Color(0xFFECE8E1), // Ganti dengan warna yang diinginkan
              ),

              AreaPopularSection(backgroundColor: Color(0xFFECE7DE),),

              Container(
                height: 5,
                color: Color(0xFFECE8E1), // Ganti dengan warna yang diinginkan
              ),

              BudgetSection()
            ],
          ),
        ),
      ),
    );
  }
}
