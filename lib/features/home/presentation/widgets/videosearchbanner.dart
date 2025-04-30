import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class VideoSearchBanner extends StatefulWidget {
  const VideoSearchBanner({super.key});

  @override
  State<VideoSearchBanner> createState() => _VideoSearchBannerState();
}

class _VideoSearchBannerState extends State<VideoSearchBanner> {
  late VideoPlayerController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/myvideo.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      }).catchError((error) {
        print("Error loading video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
      children: [
        ClipRRect(
          child: SizedBox(
            height: 350,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
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
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20)),
                          ),
                          builder: (_) => const SearchFilterModal(),
                        );
                      },
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
                        isCollapsed: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search,
                        size: 28, color: Colors.black),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) => const SearchFilterModal(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    )
        : const SizedBox(
      height: 250,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class SearchFilterModal extends StatefulWidget {
  const SearchFilterModal({super.key});

  @override
  State<SearchFilterModal> createState() => _SearchFilterModalState();
}

class _SearchFilterModalState extends State<SearchFilterModal> {
  String selectedCategory = 'Housing';
  String selectedRentType = 'Monthly';
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int? durationInDays;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          // Update tanggal checkIn dan checkOut jika ada durasi
          checkInDate = picked;
          if (durationInDays != null) {
            checkOutDate = checkInDate!.add(Duration(days: durationInDays!));
          }
        } else {
          // Hanya update checkOut jika sudah memilih checkIn
          checkOutDate = picked;
        }
      });
    }
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  List<String> getRentTypeOptions(String category) {
    if (category == 'Hotel' || category == 'Villa') {
      return ['Daily'];
    } else {
      return ['Monthly', 'Daily'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final rentOptions = getRentTypeOptions(selectedCategory);
    if (!rentOptions.contains(selectedRentType)) {
      selectedRentType = rentOptions.first;
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: ['Housing', 'Apartment', 'Hotel', 'Villa']
                  .map((item) =>
                  DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Category'),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                  // Update rent type jika opsi berubah
                  final options = getRentTypeOptions(value);
                  if (!options.contains(selectedRentType)) {
                    selectedRentType = options.first;
                  }
                });
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedRentType,
              items: rentOptions
                  .map((item) =>
                  DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Rent Type'),
              onChanged: rentOptions.length == 1
                  ? null // Lock jika hanya 1 opsi
                  : (value) => setState(() => selectedRentType = value!),
            ),
            const SizedBox(height: 12),
            // Modifikasi untuk input Duration berdasarkan Rent Type
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Duration (${selectedRentType == 'Monthly' ? 'months' : 'days'})',
                hintText: selectedRentType == 'Monthly'
                    ? 'Masukkan jumlah bulan'
                    : 'Masukkan jumlah hari',
                suffixIcon: Icon(selectedRentType == 'Monthly'
                    ? Icons.calendar_today
                    : Icons.timer),
              ),
              onChanged: (value) {
                final parsed = int.tryParse(value);
                if (parsed != null) {
                  setState(() {
                    // Sesuaikan dengan Rent Type
                    durationInDays = selectedRentType == 'Monthly'
                        ? parsed * 30 // Asumsi 1 bulan = 30 hari
                        : parsed;
                    if (checkInDate != null) {
                      checkOutDate =
                          checkInDate!.add(Duration(days: durationInDays!));
                    }
                  });
                } else {
                  setState(() {
                    durationInDays = null;
                    checkOutDate = null;
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              readOnly: durationInDays == null, // Lock Check-in jika duration kosong
              onTap: durationInDays == null ? null : () => _selectDate(context, true),
              decoration: InputDecoration(
                labelText: 'Check-in',
                hintText: checkInDate != null
                    ? formatDate(checkInDate!)
                    : 'Select date',
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20), // Jarak atas sebelum tombol
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Color(0xFF005F21),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  print('Category: $selectedCategory');
                  print('Rent Type: $selectedRentType');
                  print('Check-in: $checkInDate');
                  print('Duration: $durationInDays');
                  print('Check-out: $checkOutDate');
                },
                child: const Text(
                  'Search',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Ruang bawah
          ],
        ),
      ),
    );
  }
}





