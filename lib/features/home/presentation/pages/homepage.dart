import 'package:flutter/material.dart';
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
import '../../data/properties_api_services.dart';
import '../../model/properties_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedSubCategoryIndex = 0;
  int _selectedFilterTabIndex = 0;
  late Future<List<Property>> properties;
  late List<Map<String, dynamic>> propList = [];

  @override
  void initState(){
    super.initState();
    properties = PropertiesApiService().fetchProperties();

    properties.then((property){
      setState(() {
        propList = property.where((x) => x.tags.toLowerCase().contains("house"))
            .map((x) => {
          'idrec': x.idrec,
          'slug': x.slug,
          'tags': x.tags,
          'name': x.name,
          'description': x.description,
          'province': x.province,
          'city': x.city,
          'subdistrict': x.subdistrict,
          'village': x.village,
          'postal_code': x.postalCode,
          'address': x.address,
          'location': x.location,
          'distance': x.distance,
          'price': x.price.toJson(),
          'features': x.features.toJson(),
          'attributes': x.attributes.toJson(),
          'image': 'assets/images/ulinhouse.jpg',
          'status': x.status,
          'created_at': x.createdAt,
          'updated_at': x.updatedAt,
          'created_by': x.createdBy,
          'updated_by': x.updatedBy,
        }).toList();
      });
    });
  }

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

              SizedBox(
                height: 300,
                child: propList.isEmpty ? const Center(child: CircularProgressIndicator(),)
                    : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: propList.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 0.0),
                  itemBuilder: (context, index){
                    final property = propList[index];
                    return ProductCard(
                        image: property['image'],
                        title: property['name'],
                        location: property['location'],
                        detail: property['tags'],
                        price: property['price']['original'].toString(),
                        // badgeText: property['features'].values.first,
                        onTap: (){
                          context.push('/detailhouse', extra: property);
                          print("==================================================\n $property");
                        }
                    );
                  },
                ),
              ),

              // SizedBox(
              //   height: 300,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 16),
              //     children: [
              //       ProductCard(
              //         image: 'assets/images/ulinhouse.jpg',
              //         title: 'Jelambar',
              //         onTap: () {
              //           context.push(
              //             '/detailhouse',
              //             extra: {
              //               "data": {
              //                 "idrec": 1,
              //                 "slug": "hou_umhj_1",
              //                 "tags": "House",
              //                 "name": "Ulin Mahoni House Jaksel",
              //                 "description": "Experience modern coliving at its finest in this strategically located property. Featuring well-designed spaces, community areas, and all the amenities you need for comfortable urban living.",
              //                 "location": "Kemang, Jakarta Selatan",
              //                 "image": null // karena kamu pakai asset sementara, bisa null atau base64
              //               }
              //             },
              //           );
              //         },
              //       ),
              //       SizedBox(width: 16),
              //       ProductCard(
              //           image: 'assets/images/ulinhouse.jpg',
              //           title: 'Jelambar',
              //           onTap: () {
              //             context.push('/detailhouse');
              //           }
              //       ),
              //       SizedBox(width: 16),
              //       ProductCard(
              //           image: 'assets/images/ulinhouse.jpg',
              //           title: 'Jelambar',
              //           onTap: () {
              //             context.push('/detailhouse');
              //           }
              //       ),
              //     ],
              //   ),
              // ),

              BrowseAllButton(),

              SizedBox(
                height: 20,
              ),

              BestSellerSection(backgroundColor: Color(0xFFE8E3D9),),

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
