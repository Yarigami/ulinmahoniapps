import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Tambahkan ini
import '../../../../core/widgets/productcard.dart';
import '../../data/detailhouse_data.dart';

class RoomTypeSection extends StatelessWidget {
  final dynamic propertyData;

  const RoomTypeSection({Key? key, required this.propertyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Type',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: dummyRoomTypes.map((room) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ProductCard(
                    image: room['image'],
                    title: room['name'],
                    location: propertyData['name'] ?? 'Ulin House West Jakarta',
                    detail: room['description'],
                    price: room['price'],
                    onTap: () {
                      // Navigasi ke halaman detail dengan data room
                      context.push('/bookhouse', extra: room);
                    },
                    width: 200,
                    height: 250,
                    imageHeight: 150,
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
