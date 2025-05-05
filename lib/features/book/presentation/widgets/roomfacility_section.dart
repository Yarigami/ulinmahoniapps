import 'package:flutter/material.dart';
import '../../data/bookhouse_data.dart';

Widget buildRoomFacilitySection() {
  return Wrap(
    alignment: WrapAlignment.center,
    spacing: 16,
    runSpacing: 16,
    children: [
      _buildFacilityIcon(Icons.bed, 'Bedroom'),
      _buildFacilityIcon(Icons.shower, 'Inside\nBathroom'),
      _buildFacilityIcon(Icons.kitchen, 'Kitchen'),
      _buildFacilityIcon(Icons.chair_alt, 'Meja\nKursi'),
      _buildFacilityIcon(Icons.ac_unit, 'AC'),
      _buildFacilityIcon(Icons.storage, 'Lemari'),
    ],
  );
}

Widget _buildFacilityIcon(IconData icon, String label) {
  return SizedBox(
    width: 72,
    child: Column(
      children: [
        Icon(icon, color: Color(0xFF004D40), size: 28),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF004D40),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
