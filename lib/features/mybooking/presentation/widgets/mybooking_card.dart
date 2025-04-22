import 'package:flutter/material.dart';

class BookingCard extends StatefulWidget {
  final String image;
  final String title;
  final String location;
  final String checkIn;
  final String checkOut;
  final String status;
  final String statusText;

  const BookingCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.statusText,
  });

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'settled':
        return Colors.green;
      case 'pending':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
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
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.apartment, size: 18),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 11 : 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (widget.status.toLowerCase() != 'completed')
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _statusColor(widget.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: _statusColor(widget.status)),
                              ),
                              child: Text(
                                widget.statusText,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 10 : 11,
                                  fontWeight: FontWeight.bold,
                                  color: _statusColor(widget.status),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Check-In',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              widget.checkIn,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text(
                            'Check-Out',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              widget.checkOut,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}