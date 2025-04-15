import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/features/home/presentation/widgets/populararea.dart';
import 'package:ulinmahoniapps/features/home/presentation/widgets/promotion.dart';
import 'package:video_player/video_player.dart';
import 'package:go_router/go_router.dart';
import '../widgets/productcard.dart';
import '../widgets/filtertab.dart';
import '../widgets/filtertype.dart';
import '../widgets/bestseller.dart';
import '../widgets/budget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  int _selectedSubCategoryIndex = 0;
  int _selectedFilterTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final maroon = const Color(0xFF800000);
  final darkGreen = const Color(0xFF184D37);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/video.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              if (_controller.value.isInitialized)
                Stack(
                  children: [
                    ClipRRect(
                      child: Container(
                        height: 350,
                        width: double.infinity,
                        child: Align(
                          child: SizedBox(
                            width: _controller.value.size.width,
                            height: _controller.value.size.height,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 24,
                      right: 24,
                      bottom: 16,
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _searchController,
                                  cursorColor: Colors.grey,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black45,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Cari hunianmu',
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black45,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 12), // menengah vertikal
                                  ),

                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.search, size: 28, color: Colors.black),
                                onPressed: () {
                                  debugPrint("Mencari: ${_searchController.text}");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                ),

              Container(
                color: Colors.grey[200],
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
                selectedIndex: _selectedSubCategoryIndex, // Kirimkan selectedSubCategoryIndex
                onTypeSelected: (index) {
                  setState(() {
                    _selectedSubCategoryIndex = index; // Update nilai index ketika subkategori dipilih
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
                            context.push('/comingsoon'); // Bisa disesuaikan juga target route-nya
                        }
                        ),
                    SizedBox(width: 16),
                    ProductCard(
                        image: 'assets/images/ulinhouse.jpg',
                        title: 'Jelambar',
                        onTap: () {
                          context.push('/comingsoon'); // Bisa disesuaikan juga target route-nya
                        }
                    ),
                    SizedBox(width: 16),
                    ProductCard(
                        image: 'assets/images/ulinhouse.jpg',
                        title: 'Jelambar',
                        onTap: () {
                          context.push('/comingsoon'); // Bisa disesuaikan juga target route-nya
                        }
                    ),
                  ],
                ),
              ),

              Center(
                child: TextButton(
                  onPressed: () {
                    context.push('/browse-all'); // Gunakan .go jika mau ganti seluruh stack
                  },
                  child: const Text(
                    'Browse All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black
                    ),
                  ),
                ),
              ),

              BestSellerSection(),

              const SizedBox(height: 20),

              PromotionSection(),

              const SizedBox(height: 20),

              AreaPopularSection(),

              const SizedBox(height: 20),

              BudgetSection()
            ],
          ),
        ),
      ),
    );
  }
}





