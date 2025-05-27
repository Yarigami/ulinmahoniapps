import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/formatdate.dart';

class BookingCard extends StatefulWidget {
  final int id;
  final String image;
  final String title;
  final String roomName;
  final String checkIn;
  final String checkOut;
  final String status;
  final Map<String, dynamic> dataDetail;

  const BookingCard({
    Key? key,
    required this.id,
    required this.image,
    required this.title,
    required this.roomName,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.dataDetail,
  }) : super(key: key);

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'settled':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return GestureDetector(
      onTap: () {
        context.push('/mybookingdetails', extra: widget.dataDetail);
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 40);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.roomName,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 11 : 12,
                        color: Colors.grey[700],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(widget.status).withOpacity(0.1),
                        border: Border.all(color: _statusColor(widget.status)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.status,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 10 : 11,
                          color: _statusColor(widget.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Check-In: ${formatDate(widget.checkIn) ?? widget.checkIn}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Check-Out: ${formatDate(widget.checkOut) ?? widget.checkOut}',
                      style: const TextStyle(fontSize: 12),
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

