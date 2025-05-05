import 'package:flutter/material.dart';

const Map<String, dynamic> propertyData = {
  'name': 'Alpha Room',
  'type': 'House',
  'description':
  'Alpha Room di Ulin House West Jakarta adalah pilihan kamar premium yang mengutamakan kenyamanan dan teknologi modern. Dengan desain mewah dan fungsional, Alpha Room dilengkapi dengan smart lighting yang dapat dikontrol melalui gadget, memastikan pengalaman hunian yang praktis dan canggih. Ruangan ini didesain untuk mendukung gaya hidup dinamis anak muda, menawarkan furnitur berkualitas, koneksi WiFi cepat, serta akses ke fasilitas eksklusif seperti gym dan lounge. Alpha Room adalah kombinasi sempurna antara estetika, kenyamanan, dan inovasi dalam satu ruang tinggal.',
  'location': 'Jelambar, West Jakarta',
  'address': 'Jln Panjang , No 1-5A',
  'rating': 8.4,
  'reviewCount': 120,
  'facilities': ['Lounge', 'CCTV Area', 'Free Wifi', 'GYM'],
  'roomFacilities': [
    {'image': 'assets/images/ulinhouse.jpg', 'label': 'Bedroom'},
    {'image': 'assets/images/ulinhouse.jpg', 'label': 'Inside Bathroom'}
  ],
  'prices': [
    {
      'label': 'Monthly',  // Ganti 'Monthly' dengan 'Bulanan'
      'price': 'Rp 2.000.000/Bulan',  // Format Rupiah untuk Monthly
      'originalPrice': 'Rp 2.500.000',  // Harga asli dalam Rupiah
      'discount': 'Rp 500.000 OFF',  // Diskon dalam Rupiah
      'location': 'Jakarta, Indonesia',
      'paymentOption': 'Bayar sekarang',  // Ganti 'Pay now' dengan 'Bayar sekarang'
    },
    {
      'label': 'Daily',  // Ganti 'Daily' dengan 'Harian'
      'price': 'Rp 200.000/Hari',  // Format Rupiah untuk Daily
      'originalPrice': 'Rp 250.000',  // Harga asli dalam Rupiah
      'discount': 'Rp 50.000 OFF',  // Diskon dalam Rupiah
      'location': 'Jakarta, Indonesia',
      'paymentOption': 'Bayar sekarang',  // Ganti 'Pay now' dengan 'Bayar sekarang'
    },
  ],
};

class RoomFacilityIcons {
  static final List<Map<String, dynamic>> items = [
    {'icon': Icons.bed, 'label': 'Bedroom'},
    {'icon': Icons.shower, 'label': 'Inside Bathroom'},
    {'icon': Icons.kitchen, 'label': 'Kitchen'},
    {'icon': Icons.chair_alt, 'label': 'Meja Kursi'},
    {'icon': Icons.ac_unit, 'label': 'AC'},
    {'icon': Icons.storage, 'label': 'Lemari'},
  ];
}

