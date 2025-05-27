import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulinmahoniapps/core/layout/mainlayout.dart';
import 'package:ulinmahoniapps/core/widgets/backbutton.dart';
import 'package:ulinmahoniapps/features/book/detailproperty/model/detailproperty_model.dart';
import 'package:ulinmahoniapps/features/book/roomdetails/model/rooms_model.dart';
import 'package:ulinmahoniapps/features/auth/login/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ulinmahoniapps/core/widgets/formatcurrency.dart';
import 'package:ulinmahoniapps/features/book/payment/provider/payment_provider.dart'; // Sesuaikan path
import '../widgets/payment_method.dart';

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
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  final List<Map<String, dynamic>> paymentMethods = [
    {'icon': Icons.credit_card, 'text': 'Kartu Kredit'},
    {'icon': Icons.account_balance_wallet, 'text': 'E-Wallet'},
    {'icon': Icons.account_balance, 'text': 'Transfer Bank'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Panggil loadPaymentDetails dari notifier yang digabungkan
      ref.read(paymentNotifierProvider.notifier).loadPaymentDetails(
        room: widget.room,
        propertyData: widget.propertyData,
        rentType: widget.rentType,
        duration: widget.duration,
        checkInDate: widget.checkInDate,
        checkOutDate: widget.checkOutDate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch state dari paymentNotifierProvider (yang sudah digabungkan)
    final paymentState = ref.watch(paymentNotifierProvider);
    final authState = ref.watch(authProvider);

    // Mendengarkan hasil postBooking
    ref.listen<AsyncValue<String?>>(
      paymentNotifierProvider.select((state) => state.postBookingResult),
          (previous, next) {
        next.whenOrNull(
          data: (message) {
            if (message != null && message.isNotEmpty) { // Pastikan message tidak null/kosong
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booking berhasil: $message')),
              );
              context.go('/mybooking'); // Navigasi setelah sukses
            }
          },
          error: (err, st) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal booking: ${err.toString()}')),
            );
          },
        );
      },
    );

    // Gunakan .when untuk menangani loading/error state dari paymentCalculationData
    return paymentState.paymentCalculationData.when(
      loading: () => const MainLayout(
        currentIndex: 0,
        showBottomNav: false,
        showNavBar: false,
        child: Scaffold(
          backgroundColor: Color(0xFF333333),
          body: Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      ),
      error: (err, stack) => MainLayout(
        currentIndex: 0,
        showBottomNav: false,
        showNavBar: false,
        child: Scaffold(
          backgroundColor: const Color(0xFF333333),
          body: Center(
            child: Text('Error: ${err.toString()}', style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
      data: (data) {
        final roomData = data['roomData'] as Map<String, dynamic>;
        final itemDetails = data['itemDetails'] as List<Map<String, dynamic>>;
        final afterOriginalTotalFees = (data['afterOriginalTotalFees'] as num?)?.toDouble();

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
                              roomData['name']?.toString() ?? '-',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              roomData['type']?.toString() ?? '-',
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
                                roomData['propertyName']?.toString() ?? '-',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            roomData['name']?.toString() ?? '-',
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
                              Text(roomData['checkIn']?.toString() ?? '-'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tanggal Keluar'),
                              Text(roomData['checkOut']?.toString() ?? '-'),
                            ],
                          ),
        const SizedBox(height: 24),
Container(
  decoration: BoxDecoration(
    color: const Color(0xFFF0F0F0),
    borderRadius: BorderRadius.circular(10),
  ),
  padding: const EdgeInsets.all(12),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: const [
          Icon(Icons.email, color: Colors.grey),
          SizedBox(width: 8),
          Text.rich(
            TextSpan(
              text: 'Isi Data Pemesan ',
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(color: Colors.red),
                ),
              ],
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      const Icon(Icons.add, color: Colors.grey),
    ],
  ),
),
const SizedBox(height: 16),
const Text(
  'Metode Pembayaran',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 8),
Column(
  children: paymentMethods.map((method) => PaymentMethodItem(
    icon: method['icon'],
    text: method['text'],
  )).toList(),
),

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
                                    Text('Rp ${int.parse(item['price']?.toString() ?? '0').toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
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
                                // Panggil fungsi calculateTotalPrice dari notifier yang sudah digabungkan
                                formatCurrency(ref.read(paymentNotifierProvider.notifier).calculateTotalPrice(itemDetails, (afterOriginalTotalFees) ?? 0)),
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
                                  if (user != null) {
                                    ref.read(paymentNotifierProvider.notifier).postBooking();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Harap Login'),
                                        content: const Text('Silakan login terlebih dahulu untuk melanjutkan.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              ctx.go('/login');
                                            },
                                            child: const Text('Login'),
                                          ),
                                          TextButton(
                                            onPressed: () => ctx.pop(),
                                            child: const Text('Batal'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
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