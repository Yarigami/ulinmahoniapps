import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulinmahoniapps/core/layout/mainlayout.dart';
import 'package:ulinmahoniapps/core/widgets/backbutton.dart';
import 'package:ulinmahoniapps/features/book/detailproperty/model/detailproperty_model.dart';
import '../../../roomdetails/model/rooms_model.dart';
import '../../../../auth/login/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/formatcurrency.dart';
import '../widgets/payment_method.dart';
import '../../provider/payment_provider.dart';
import '../../model/payment_model.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final RoomModel room;
  final DetailPropertyModel propertyData;
  final String rentType;
  final int duration;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  const PaymentPage({
    super.key,
    required this.room,
    required this.propertyData,
    required this.rentType,
    required this.duration,
    required this.checkInDate,
    required this.checkOutDate,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  double? afterDiscountedTotalFees;
  double? afterOriginalTotalFees;
  Map<String, dynamic>? roomData;
  List<Map<String, dynamic>> itemDetails = [];
  List<Map<String, dynamic>> paymentMethods = [
    {'icon': Icons.credit_card, 'text': 'Kartu Kredit'},
    {'icon': Icons.account_balance_wallet, 'text': 'E-Wallet'},
    {'icon': Icons.account_balance, 'text': 'Transfer Bank'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void fetchData() {
    final room = widget.room;
    final rentType = widget.rentType;
    final duration = widget.duration;
    final property = widget.propertyData;

    print("====FetchdataPayment====");
    print(room.id);
    print(rentType);
    print(duration);
    print(property.name);

    // void debugPrintType(dynamic value) {
    //   if (value is int) {
    //     print('Tipe: int, Nilai: $value');
    //   } else if (value is double) {
    //     print('Tipe: double, Nilai: $value');
    //   } else if (value is String) {
    //     print('Tipe: String, Nilai: "$value"');
    //   } else {
    //     print('Tipe tidak dikenali: ${value.runtimeType}, Nilai: $value');
    //   }
    // }
    // debugPrintType(widget.room.priceDiscountedDaily);
    // debugPrintType(widget.room.priceOriginalDaily);
    // debugPrintType(widget.room.priceDiscountedMonthly);
    // debugPrintType(widget.room.priceOriginalMonthly);

    double adminfees = 0;

    int monthlyduration = 0;
    int dailyduration = 0;

    final discountedDailyPrice = parseToDouble(widget.room.priceDiscountedDaily);
    var originalDailyPrice = parseToDouble(widget.room.priceOriginalDaily);

    final discountedMonthlyPrice = parseToDouble(widget.room.priceDiscountedMonthly);
    var originalMonthlyPrice = parseToDouble(widget.room.priceOriginalMonthly);

    print("====price====");
    print(widget.room.priceOriginalMonthly);
    print(widget.room.priceDiscountedMonthly);
    print(widget.room.priceOriginalDaily);
    print(widget.room.priceDiscountedDaily);
    print(discountedDailyPrice);
    print(originalDailyPrice);
    print(discountedMonthlyPrice);
    print(originalMonthlyPrice);

    double originalTotal = 0;
    double discountedTotal = 0;

    if (rentType == 'daily') {
      // Debugging untuk daily rental
      print('--- Perhitungan Harian ---');
      print('rentType: $rentType');
      print('originalDailyPrice: $originalDailyPrice');
      print('discountedDailyPrice: $discountedDailyPrice');

      originalTotal = originalDailyPrice * duration;
      dailyduration = duration;
      originalMonthlyPrice = 0;
      adminfees = originalTotal * 0.10;

      print('duration (days): $dailyduration');
      print('originalTotal (daily): $originalTotal (setelah $originalDailyPrice * $duration)');
      print('discountedTotal (daily): $discountedTotal (setelah $discountedDailyPrice * $duration)');

    } else if (rentType == 'monthly') {
      // Debugging untuk monthly rental
      print('--- Perhitungan Bulanan ---');
      print('rentType: $rentType');
      print('originalMonthlyPrice: $originalMonthlyPrice');
      print('discountedMonthlyPrice: $discountedMonthlyPrice');

      originalTotal = originalMonthlyPrice * duration;
      monthlyduration = duration;
      originalDailyPrice = 0;
      adminfees = originalTotal * 0.10;

      print('duration (months): $monthlyduration');
      print('originalTotal (monthly): $originalTotal (setelah $originalMonthlyPrice * $duration)');
      print('discountedTotal (monthly): $discountedTotal (setelah $discountedMonthlyPrice * $duration)');
    }

    print("====total===");
    print(originalTotal);
    print(discountedTotal);

    final originalFee = originalTotal * 0.10;
    final discountedFee = discountedTotal * 0.10;

    print("====fee====");
    print(originalFee);
    print(discountedFee);

    setState(() {
      roomData = {
        'name': room.name ?? '-',
        'id': room.id ?? '',
        'checkIn': widget.checkInDate.toString().substring(0, 10),
        'checkOut': widget.checkOutDate.toString().substring(0, 10),
        'type': room.type ?? '-',
        'propertyName': property.name ?? '-',
        'propertyId': property.id ?? '',
        'propertyType': property.tags ?? '-',
        'location': property.location ?? '-',
        'daily_price': originalDailyPrice,
        'monthly_price': originalMonthlyPrice,
        'rentType': rentType,
        'booking_months': monthlyduration,
        'booking_days': dailyduration,
        'admin_fee': adminfees,
      };

      itemDetails = [
        {
          'name': '$duration ${rentType == 'daily' ? 'Hari' : 'Bulan'} (Harga Normal)',
          'price': originalTotal.toStringAsFixed(0),
          'rawPrice': originalTotal,
          'type': 'original',
        },
        // {
        //   'name': '$duration ${rentType == 'daily' ? 'Hari' : 'Bulan'} (Harga Diskon)',
        //   'price': discountedTotal.toStringAsFixed(0),
        //   'rawPrice': discountedTotal,
        //   'type': 'discounted',
        // },
      ];

      afterOriginalTotalFees = originalFee;
    });
  }

  Future<bool> onBookingSubmit() async {
    final user = ref.watch(authProvider).user.value;
    if (user == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Harap Login'),
          content: const Text('Silakan login terlebih dahulu untuk melanjutkan.'),
          actions: [
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Batal'),
            ),
          ],
        ),
      );
      return false;
    }

    final bookingRequest = BookingRequest(
      userId: user.id,
      userName: user.name,
      userPhoneNumber: '090847289729',
      propertyId: roomData!['propertyId'].toString(),
      propertyName: roomData!['propertyName'].toString(),
      checkIn: roomData!['checkIn'].toString(),
      checkOut: roomData!['checkOut'].toString(),
      roomName: roomData!['name'].toString(),
      roomId: roomData!['id'].toString(),
      userEmail: user.email,
      dailyPrice: parseToDouble(roomData!['daily_price']),
      monthlyPrice: parseToDouble(roomData!['monthly_price']),
      adminfee: parseToDouble(roomData!['admin_fee']),
      propertyType: roomData!['propertyType'].toString(),
      bookingType: roomData!['rentType'].toString(),
      bookingDays: roomData!['booking_days'],
      bookingMonths: roomData!['booking_months'],
    );

    // Print semua variabel sebelum buat BookingRequest
    print('userId: ${user.id}');
    print('userName: ${user.name}');
    print('userPhoneNumber: 090847289729');
    print('propertyId: ${roomData!['propertyId'].toString()}');
    print('propertyName: ${roomData!['propertyName'].toString()}');
    print('checkIn: ${roomData!['checkIn'].toString()}');
    print('checkOut: ${roomData!['checkOut'].toString()}');
    print('roomName: ${roomData!['name'].toString()}');
    print('roomId: ${roomData!['id'].toString()}');
    print('adminfees: ${parseToDouble(roomData!['admin_fee'])}');
    print('userEmail: ${user.email}');
    print('dailyPrice (calculated): ${parseToDouble(roomData!['daily_price'])}');
    print('monthlyPrice (calculated): ${parseToDouble(roomData!['monthly_price'])}');
    print('propertyType: ${roomData!['propertyType'].toString()}');
    print('rentType selected: ${roomData!['rentType']}');

    try {
      await ref.read(paymentProvider.notifier).postBooking(bookingRequest.toJson());
      final state = ref.read(paymentProvider);

      return state.maybeWhen(
        data: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Booking berhasil: $message')),
          );
          return true;
        },
        error: (err, st) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal booking: $err')),
          );
          return false;
        },
        orElse: () => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat booking')),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (roomData == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final authState = ref.read(authProvider);
    final user = authState.user.value;

    return MainLayout(
      currentIndex: 0,
      showBottomNav: false,
      showNavBar: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF333333),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ulinhouse.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 20,
                    left: 10,
                    child: CustomBackButton(),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roomData?['name']?.toString() ?? '-',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          roomData?['type']?.toString() ?? '-',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.home, color: Colors.black),
                          const SizedBox(width: 8),
                          Text(
                            widget.room.propertyName.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        roomData?['name']?.toString() ?? '-',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tipe Sewa'),
                          Text(widget.rentType.toString()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Durasi'),
                          // Ubah baris ini:
                          Text(
                              '${widget.duration} ${widget.rentType == 'daily' ? 'Hari' : 'Bulan'}'
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tanggal Masuk'),
                          Text(widget.checkInDate.toString().substring(0, 10)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tanggal Keluar'),
                          Text(widget.checkOutDate.toString().substring(0, 10)),
                        ],
                      ),
                      // const SizedBox(height: 24),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xFFF0F0F0),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   padding: const EdgeInsets.all(12),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Row(
                      //         children: const [
                      //           Icon(Icons.email, color: Colors.grey),
                      //           SizedBox(width: 8),
                      //           Text.rich(
                      //             TextSpan(
                      //               text: 'Isi Data Pemesan ',
                      //               children: [
                      //                 TextSpan(
                      //                   text: '*',
                      //                   style: TextStyle(color: Colors.red),
                      //                 ),
                      //               ],
                      //               style: TextStyle(color: Colors.grey),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const Icon(Icons.add, color: Colors.grey),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 16),
                      // const Text(
                      //   'Metode Pembayaran',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // Column(
                      //   children: paymentMethods.map((method) => PaymentMethodItem(
                      //     icon: method['icon'],
                      //     text: method['text'],
                      //   )).toList(),
                      // ),
                      const SizedBox(height: 24),
                      const Text(
                        'Rincian Harga',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: itemDetails.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item['name']),
                                Text('Rp ${int.parse(item['price']).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Pajak dan Biaya'),
                          Text('Rp ${((afterOriginalTotalFees) ?? 0).toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
                        ],
                      ),
                      const Divider(height: 32, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Harga',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            // Panggil fungsi formatCurrency di sini
                            formatCurrency(calculateTotalPrice(itemDetails, (afterOriginalTotalFees) ?? 0)),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
        Center(
        child: FractionallySizedBox(
        widthFactor: 0.925,
        child: ElevatedButton(
          onPressed: () {
            onBookingSubmit();
            context.go('/mybooking');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: user != null ? const Color(0xFF005F21) : Colors.grey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_cart, size: 24, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Bayar Sekarang',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    )
    ],),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

  static double calculateTotalPrice(List<Map<String, dynamic>> items, double taxFee) {
    double totalPrice = 0;

    for (var item in items) {
      print('=========');
      print(item['type']);
      if (item['type'] == 'original') {
        totalPrice += item['rawPrice'];
      }
    }

    totalPrice += taxFee;

    return totalPrice;
  }
}

double parseToDouble(dynamic value) {
  if (value == null) {
    print('DEBUG: Input value is null. Returning 0.0.');
    return 0.0;
  }

  String stringValue = value.toString();
  print('DEBUG: Original string value: "$stringValue" (type: ${value.runtimeType})');

  // Bersihkan "Rp", spasi, dan pastikan hanya ada satu titik sebagai pemisah desimal
  // dan tidak ada koma sebagai pemisah ribuan.
  String cleanedValue = stringValue
      .replaceAll('Rp', '')   // Hapus 'Rp'
      .replaceAll(' ', '') ;   // Hapus spasi

  // Ini juga penting jika angka awalnya tidak memiliki pemisah ribuan tetapi memiliki koma desimal,
  // atau jika API mengembalikan angka sebagai double murni tanpa pemisah apapun.
  // Contoh: "125000.0000" -> "125000." (jika titik terakhir dihilangkan)
  // Pastikan trailing zeros setelah titik desimal dihilangkan secara efektif oleh double.tryParse

  print('DEBUG: Cleaned string value for double: "$cleanedValue"');

  double? parsedDouble = double.tryParse(cleanedValue);

  if (parsedDouble != null) {
    print('DEBUG: Successfully parsed to double: $parsedDouble');
    return parsedDouble;
  } else {
    print('DEBUG: Failed to parse "$cleanedValue" to a double. Returning 0.0.');
    return 0.0;
  }
}

int parseToInt(dynamic value) {
  if (value == null) {
    print('DEBUG: Input value is null. Returning 0.');
    return 0;
  }

  String stringValue = value.toString();
  print('DEBUG: Original string value: "$stringValue" (type: ${value.runtimeType})');

  // Gunakan logika pembersihan yang sama dengan parseToDouble
  String cleanedValue = stringValue
      .replaceAll('Rp', '')
      .replaceAll(' ', '');


  print('DEBUG: Cleaned string value for int (pre-parse): "$cleanedValue"');

  // Parse sebagai double terlebih dahulu untuk menangani desimal jika ada
  double? parsedDouble = double.tryParse(cleanedValue);

  if (parsedDouble != null) {
    // Konversi ke int
    int result = parsedDouble.toInt(); // Ini akan membuang bagian desimal
    print('DEBUG: Successfully parsed to int: $result');
    return result;
  } else {
    print('DEBUG: Failed to parse "$cleanedValue" to a number. Returning 0.');
    return 0;
  }
}

