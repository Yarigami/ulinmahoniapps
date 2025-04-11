import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  int _selectedBudgetIndex = 0;
  int _selectedSubCategoryIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final maroon = const Color(0xFF800000);
  final darkGreen = const Color(0xFF184D37);

  final List<String> _budgetOptions = ['< 1 Juta', '1 - 2 Juta', '> 2 Juta'];

  final List<Map<String, dynamic>> _subCategories = [
    {'label': 'Populer', 'icon': Icons.thumb_up},
    {'label': 'Bogor', 'icon': Icons.location_city},
    {'label': 'Jelambar', 'icon': Icons.place},
    {'label': 'Mewah', 'icon': Icons.diamond},
    {'label': 'Terdekat', 'icon': Icons.near_me},
    {'label': 'Strategis', 'icon': Icons.map},
    {'label': 'Perkotaan', 'icon': Icons.apartment},
  ];

  final List<Map<String, dynamic>> _filterTabs = [
    {'label': 'Housing', 'icon': Icons.home},
    {'label': 'Apartment', 'icon': Icons.apartment},
    {'label': 'Hotel', 'icon': Icons.hotel},
    {'label': 'Villa', 'icon': Icons.villa},
  ];
  int _selectedFilterTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/intro.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
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
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.cover,
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
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
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


              const SizedBox(height: 12),

              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filterTabs.length,
                  itemBuilder: (context, index) {
                    final tab = _filterTabs[index];
                    final isActive = _selectedFilterTabIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilterTabIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isActive ? darkGreen : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(tab['icon'], size: 16, color: isActive ? Colors.white : Colors.black),
                            const SizedBox(width: 6),
                            Text(tab['label'],
                                style: TextStyle(
                                  color: isActive ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: List.generate(_subCategories.length, (index) {
                    final isSelected = _selectedSubCategoryIndex == index;
                    final color = isSelected ? darkGreen : maroon;
                    final icon = _subCategories[index]['icon'] as IconData;
                    final label = _subCategories[index]['label'] as String;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSubCategoryIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 20, color: color),
                            const SizedBox(height: 4),
                            Text(label, style: TextStyle(fontSize: 12, color: color)),
                            const SizedBox(height: 4),
                            if (isSelected)
                              Container(
                                height: 2,
                                width: 20,
                                color: color,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'Jelambar'),
                    SizedBox(width: 16),
                    HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'Jelambar'),
                  ],
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 26),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "BEST SELLLER",
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 200, // atur tinggi sesuai desain
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: const [
                          HousingCard(
                            image: 'assets/images/ulinhouse.jpg',
                            title: 'ULIN HOUSE WEST JAKARTA',
                          ),
                          SizedBox(width: 12),
                          HousingCard(
                            image: 'assets/images/ulinhouse.jpg',
                            title: 'ULIN HOUSE WEST JAKARTA 2',
                          ),
                          SizedBox(width: 12),
                          HousingCard(
                            image: 'assets/images/ulinhouse.jpg',
                            title: 'ULIN HOUSE WEST JAKARTA 3',
                          ),
                          SizedBox(width: 12),
                          HousingCard(
                            image: 'assets/images/ulinhouse.jpg',
                            title: 'ULIN HOUSE WEST JAKARTA 4',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      child: Text("PROMOTION", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 140, // tambahkan tinggi eksplisit
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/ulinhouse.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("AREA TERPOPULER", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Expanded(child: HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'Jakarta Barat')),
                    SizedBox(width: 16),
                    Expanded(child: HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'Bogor')),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                height: 290,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("SESUAIKAN BUDGETMU", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _budgetOptions.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedBudgetIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedBudgetIndex = index);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? darkGreen : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  _budgetOptions[index],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: const [
                          HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'ULIN HOUSE WEST JAKARTA'),
                          SizedBox(width: 16),
                          HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'ULIN HOUSE EAST JAKARTA'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterTab extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool active;

  const FilterTab({super.key, required this.label, required this.icon, this.active = false});

  @override
  State<FilterTab> createState() => _FilterTabState();
}

class _FilterTabState extends State<FilterTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: widget.active ? const Color(0xFF184D37) : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(widget.icon, size: 16, color: widget.active ? Colors.white : Colors.black),
          const SizedBox(width: 6),
          Text(widget.label,
              style: TextStyle(
                color: widget.active ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

class HousingCard extends StatefulWidget {
  final String image;
  final String title;

  const HousingCard({super.key, required this.image, required this.title});

  @override
  State<HousingCard> createState() => _HousingCardState();
}

class _HousingCardState extends State<HousingCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(widget.image, height: 120, width: 220, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
