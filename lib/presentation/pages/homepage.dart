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

  final maroon = const Color(0xFF800000);
  final darkGreen = const Color(0xFF184D37);

  final List<String> _budgetOptions = ['< 1 Juta', '1 - 2 Juta', '> 2 Juta'];

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
                        height: 600, // Tinggi video ditambah agar layout mirip desain
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
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Cari hunianmu", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Text("Tanggal - Lokasi", style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              else
                const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                ),

              const SizedBox(height: 12),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    FilterTab(label: 'Housing', icon: Icons.home, active: true),
                    FilterTab(label: 'Apartment', icon: Icons.apartment),
                    FilterTab(label: 'Hotel', icon: Icons.hotel),
                    FilterTab(label: 'Villa', icon: Icons.villa),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    SubCategoryTab(label: 'Populer'),
                    SubCategoryTab(label: 'Bogor'),
                    SubCategoryTab(label: 'Jelambar'),
                    SubCategoryTab(label: 'Mewah'),
                    SubCategoryTab(label: 'Terdekat'),
                    SubCategoryTab(label: 'Strategis'),
                    SubCategoryTab(label: 'Perkotaan'),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 180,
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

              const SizedBox(height: 28),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Best Seller", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'ULIN HOUSE WEST JAKARTA'),
                  ],
                ),
              ),


              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Promotion", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/ulinhouse.jpg', fit: BoxFit.cover),
                ),
              ),

              const SizedBox(height: 28),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Area Terpopuler", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Expanded(child: HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'JAKARTA BARAT')),
                    SizedBox(width: 16),
                    Expanded(child: HousingCard(image: 'assets/images/ulinhouse.jpg', title: 'BOGOR')),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Sesuaikan Budgetmu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),

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

class SubCategoryTab extends StatefulWidget {
  final String label;

  const SubCategoryTab({super.key, required this.label});

  @override
  State<SubCategoryTab> createState() => _SubCategoryTabState();
}

class _SubCategoryTabState extends State<SubCategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w500)),
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
          Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
