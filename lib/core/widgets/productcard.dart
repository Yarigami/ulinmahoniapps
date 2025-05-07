import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String image;
  final String title;
  final String location;
  final String detail;
  final String price;
  final String? badgeText;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double imageHeight;

  final maroon = const Color(0xFF800000);
  final darkGreen = const Color(0xFF134E3A);

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    this.location = 'Domisili',
    this.detail = 'Detail belum tersedia',
    this.price = 'Harga belum ditentukan',
    this.badgeText = 'Diskon 100%',
    this.onTap,
    this.width = 300,
    this.height = 200,
    this.imageHeight = 170,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    widget.image,
                    height: widget.imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: widget.imageHeight,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 40),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          widget.location,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              widget.detail,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
    if (widget.badgeText != null && widget.badgeText!.isNotEmpty)

          IntrinsicWidth( // Tambahkan IntrinsicWidth agar ukuran konten sesuai
    child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
    color: Colors.green.shade100,
    borderRadius: BorderRadius.circular(5),
    border: Border.all(
    color: Colors.green.shade600,
    width: 1,
    ),
    ),
    child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    Icon(Icons.check_circle, size: 14, color: Colors.green[800]),
    const SizedBox(width: 4),
    Text(
    widget.badgeText!,
    style: const TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    ),
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    ),
    ],
    ),
    ),
    ),
            const SizedBox(height: 4),
            Text(
              widget.price,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF800000),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

