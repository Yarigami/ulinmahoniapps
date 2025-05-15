import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:ulinmahoniapps/features/book/detailproperty/model/detailproperty_model.dart';
import '../../../../../../core/layout/mainlayout.dart';
import '../../../../../../core/widgets/backbutton.dart';
import '../widgets/roomfacility_section.dart';
import 'package:go_router/go_router.dart';
import '../../model/rooms_model.dart';
import '../widgets/inputform_section.dart';

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
  bool _isLoading = false;
  RoomModel? _roomData;
  DetailPropertyModel? _propertyData;
  String? _errorMessage;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  TextEditingController _checkInDateController = TextEditingController();
  TextEditingController _checkOutDateController = TextEditingController();
  // Rent Type: 'daily' or 'monthly'
  String? _rentType;
  // Duration: int, jumlah hari jika daily, jumlah bulan jika monthly
  int? _duration;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRoomDetails();
    });
  }

  void _loadRoomDetails() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = GoRouterState.of(context).extra;
      if (data != null && data is Map<String, dynamic>) {
        final room = data['room'];
        final property = data['property'];
        if (room is RoomModel && property is DetailPropertyModel) {
          setState(() {
            _roomData = room;
            _propertyData = property;
          });
          print("=====bookingdata non build=====");
          print(_roomData?.id);
          print(_roomData);
        } else {
          setState(() {
            _errorMessage = 'Data has invalid type.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'No data provided.';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load room details.';
        _isLoading = false;
      });
    }
  }

  Future<void> _selectCheckInDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate ?? DateTime.now(),
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
      setState(() {
        // Set check-in time to 2 PM (14:00)
        _checkInDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          14, // 2 PM
          0, // Minutes
        );
        _checkInDateController.text =
            DateFormat('dd-MM-yyyy HH:mm').format(_checkInDate!);
        _updateCheckOutDate();
      });
    }
  }
  void _updateCheckOutDate() {
    if (_checkInDate != null && _duration != null) {
      DateTime checkOut;
      if (_rentType == 'daily') {
        checkOut = _checkInDate!.add(Duration(days: _duration!));
      } else {
        // _rentType == 'monthly'
        checkOut = DateTime(
          _checkInDate!.year,
          _checkInDate!.month + _duration!,
          _checkInDate!.day,
        );
      }
      // Set check-out time to 12 PM (12:00)
      final checkOutWithTime = DateTime(
        checkOut.year,
        checkOut.month,
        checkOut.day,
        12, // 12 PM
        0, // Minutes
      );
      _checkOutDate = checkOutWithTime;
      _checkOutDateController.text =
          DateFormat('dd-MM-yyyy HH:mm').format(checkOutWithTime);
    } else {
      _checkOutDate = null;
      _checkOutDateController.clear();
    }
  }
  void _onDurationChanged(int? value) {
    if (value == null) return;
    setState(() {
      _duration = value;
      _updateCheckOutDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(roomDataProvider.notifier).state = bookingData(
    //   room: _roomData,
    //   rentType: _rentType,
    //   duration: _duration,
    //   checkInDate: _checkInDate!,
    //   checkOutDate: _checkOutDate!,
    // );

    final bookingData = {
      'room': _roomData,
      'propertyData': _propertyData,
      'rentType': _rentType,
      'duration': _duration,
      'checkInDate': _checkInDate,
      'checkOutDate': _checkOutDate,
    };

    final data = GoRouterState.of(context).extra;
    if (data != null && data is Map<String, dynamic>) {
      final room = data['room'];
      final property = data['property'];
      if (room is RoomModel && property is DetailPropertyModel) {
        setState(() {
          _roomData = room;
          _propertyData = property;
        });
        print("=====bookingdata non build=====");
        print(_roomData?.id);
        print(_roomData);
      }
      }

    // final data = GoRouterState.of(context).extra as Map<String, dynamic>?;
    // _roomData = data?['room'] as RoomModel;
    // _propertyData = data?['propertyData'] as DetailPropertyModel; // Ganti dengan tipe sesuai datamu
    print("=====bookingdata=====");
    print(_propertyData?.id);
    print(_propertyData);
    print(_roomData?.id);
    print(_roomData);
    print(bookingData);
    return MainLayout(
      currentIndex: 0,
      showNavBar: false,
      showBottomNav: false,
      showContactBar: true,
      pesansekarangbutton: true,
      contactBarData: bookingData,
      child: SafeArea(
        child: Container(
          child:
          // _isLoading
          //     ? const Center(child: CircularProgressIndicator())
          //     // : _errorMessage != null
          //     // ? Center(child: Text('Error: \$_errorMessage'))
          //     // : _roomData == null
          //     // ? const Center(child: Text('No room data available.'))
          //     :
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/ulinhouse.jpg'),
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
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            _roomData?.name ?? 'Loading...',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _roomData?.type ?? '',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text("Rp.",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white)),
                              Text(
                                (_roomData?.price['discounted']?['monthly'] ??
                                    'N/A')
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              const Text("/Bulan",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white)),
                              const SizedBox(width: 12),
                              const Text("Rp.",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white)),
                              Text(
                                (_roomData?.price['original']?['daily'] ??
                                    'N/A')
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              const Text("/Hari",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white)),
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
                    margin:
                    const EdgeInsets.symmetric(horizontal: 16),
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
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
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
                          _roomData?.descriptions ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.stairs,
                                color: Color(0xFF004D40)),
                            const SizedBox(width: 4),
                            const Text('Lantai '),
                            Text(_roomData?.level ?? '-'),
                          ],
                        ),
                        RoomInputSection(
                          rentType: _rentType,
                          duration: _duration,
                          checkInDate: _checkInDate,
                          checkOutDate: _checkOutDate,
                          checkInDateController: _checkInDateController,
                          checkOutDateController: _checkOutDateController,
                          onRentTypeChanged: (value) {
                            setState(() {
                              _rentType = value;
                              _duration = null;
                              _checkInDateController.clear();
                              _checkOutDateController.clear();
                              _checkInDate = null;
                              _checkOutDate = null;
                            });
                          },
                          onDurationChanged: _onDurationChanged,
                          onSelectCheckInDate: _selectCheckInDate,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Room Facility',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
      ),
    );
  }

@override
  void dispose() {
    _checkInDateController.dispose();
    _checkOutDateController.dispose();
    super.dispose();
  }
}