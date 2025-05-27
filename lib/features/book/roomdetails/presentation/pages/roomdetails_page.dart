import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../provider/roomdetails_provider.dart'; // Sesuaikan path

import '../../../../../core/layout/mainlayout.dart';
import '../../../../../core/widgets/backbutton.dart';
import '../widgets/roomfacility_section.dart'; // Pastikan path ini benar
import '../../model/rooms_model.dart'; // Pastikan path ini benar
import '../../../detailproperty/model/detailproperty_model.dart';
import '../widgets/inputform_section.dart'; // Pastikan path ini benar

class RoomDetailsPage extends ConsumerStatefulWidget {
  final RoomModel room;
  final DetailPropertyModel propertyData;

  const RoomDetailsPage({
    Key? key,
    required this.room,
    required this.propertyData,
  }) : super(key: key);
  @override
  ConsumerState<RoomDetailsPage> createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends ConsumerState<RoomDetailsPage> {
  // TextEditingController tetap di sini karena terkait dengan UI
  late TextEditingController _checkInDateController;
  late TextEditingController _checkOutDateController;

  @override
  void initState() {
    super.initState();
    _checkInDateController = TextEditingController();
    _checkOutDateController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Panggil loadRoomDetails dari notifier
      ref.read(roomDetailsProvider.notifier).loadRoomDetails(widget.room, widget.propertyData);
      _updateDateControllers(); // Update controller saat pertama kali load
    });
  }

  @override
  void dispose() {
    _checkInDateController.dispose();
    _checkOutDateController.dispose();
    super.dispose();
  }

  // Helper function untuk mengupdate teks controller dari state provider
  void _updateDateControllers() {
    final state = ref.read(roomDetailsProvider).value;
    if (state != null) {
      final checkInDate = state['checkInDate'] as DateTime?;
      final checkOutDate = state['checkOutDate'] as DateTime?;

      if (checkInDate != null) {
        _checkInDateController.text = DateFormat('dd-MM-yyyy HH:mm').format(checkInDate);
      } else {
        _checkInDateController.clear();
      }

      if (checkOutDate != null) {
        _checkOutDateController.text = DateFormat('dd-MM-yyyy HH:mm').format(checkOutDate);
      } else {
        _checkOutDateController.clear();
      }
    }
  }

  Future<void> _selectCheckInDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ref.read(roomDetailsProvider).value?['checkInDate'] ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF005F21),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      ref.read(roomDetailsProvider.notifier).updateCheckInDate(picked);
      _updateDateControllers(); // Update controller setelah tanggal dipilih
    }
  }

  void _onDurationChanged(int? value) {
    ref.read(roomDetailsProvider.notifier).updateDuration(value);
    _updateDateControllers(); // Update controller setelah durasi berubah
  }

  void _onRentTypeChanged(String? value) {
    ref.read(roomDetailsProvider.notifier).updateRentType(value);
    _updateDateControllers(); // Update controller setelah rent type berubah
  }

  @override
  Widget build(BuildContext context) {
    // Watch state dari provider
    final roomDetailsState = ref.watch(roomDetailsProvider);

    return roomDetailsState.when(
      loading: () => MainLayout(
        currentIndex: 0,
        showNavBar: false,
        showBottomNav: false,
        showContactBar: true,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => MainLayout(
        currentIndex: 0,
        showNavBar: false,
        showBottomNav: false,
        showContactBar: true,
        child: Center(child: Text('Error: $err')),
      ),
      data: (data) {
        final _roomData = data['room'] as RoomModel?;
        final _propertyData = data['propertyData'] as DetailPropertyModel?;
        final _rentType = data['rentType'] as String?;
        final _duration = data['duration'] as int?;
        final _checkInDate = data['checkInDate'] as DateTime?;
        final _checkOutDate = data['checkOutDate'] as DateTime?;

        // Data yang akan dilewatkan ke contactBarData
        final bookingData = {
          'room': _roomData,
          'propertyData': _propertyData,
          'rentType': _rentType,
          'duration': _duration,
          'checkInDate': _checkInDate,
          'checkOutDate': _checkOutDate,
        };

        print('========= Booking Data from Provider =========');
        print('Room: $_roomData');
        print('Price Original Daily: ${_roomData?.priceOriginalDaily}');
        print('Price Discounted Daily: ${_roomData?.priceDiscountedDaily}');
        print('Price Original Monthly: ${_roomData?.priceOriginalMonthly}');
        print('Price Discounted Monthly: ${_roomData?.priceDiscountedMonthly}');
        print('Property Data: $_propertyData');
        print('Rent Type: $_rentType');
        print('Duration: $_duration');
        print('Check-in Date: $_checkInDate');
        print('Check-out Date: $_checkOutDate');
        print('============================================');

        // Handle case where _roomData or _propertyData is still null
        if (_roomData == null || _propertyData == null) {
          // This should ideally not happen if loadRoomDetails always provides data
          // But as a fallback, show a loading/error state
          return MainLayout(
            currentIndex: 0,
            showNavBar: false,
            showBottomNav: false,
            showContactBar: true,
            child: Center(child: Text('Loading room details...')),
          );
        }

        return MainLayout(
          currentIndex: 0,
          showNavBar: false,
          showBottomNav: false,
          showContactBar: true,
          pesansekarangbutton: true,
          contactBarData: bookingData,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/ulinhouse.jpg'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 16,
                        left: 16,
                        child: CustomBackButton(),
                      ),
                      Positioned(
                        bottom: 60,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _roomData.name ?? 'N/A', // Gunakan _roomData dari provider
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _roomData.type ?? 'N/A',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text("Rp.",
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                                Text(
                                  (_roomData.priceDiscountedMonthly ?? 'N/A').toString(),
                                  style: const TextStyle(fontSize: 14, color: Colors.white),
                                ),
                                const Text("/Bulan",
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                                const SizedBox(width: 12),
                                const Text("Rp.",
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                                Text(
                                  (_roomData.priceOriginalDaily ?? 'N/A').toString(),
                                  style: const TextStyle(fontSize: 14, color: Colors.white),
                                ),
                                const Text("/Hari",
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tentang",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            _roomData.descriptions ?? 'N/A',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.stairs, color: Color(0xFF004D40)),
                              const SizedBox(width: 4),
                              const Text('Lantai '),
                              Text(_roomData.level ?? 'N/A'),
                            ],
                          ),
                          RoomInputSection(
                            rentType: _rentType,
                            duration: _duration,
                            checkInDate: _checkInDate,
                            checkOutDate: _checkOutDate,
                            checkInDateController: _checkInDateController,
                            checkOutDateController: _checkOutDateController,
                            onRentTypeChanged: _onRentTypeChanged,
                            onDurationChanged: _onDurationChanged,
                            onSelectCheckInDate: _selectCheckInDate,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Room Facility',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: buildRoomFacilitySection(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}