import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';

class BrowseAllButton extends StatelessWidget {
  const BrowseAllButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * (7 / 8);

    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: TextButton(
          onPressed: () {
            context.push('/browse-all');
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFF5F4F1),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
          ),
          child: const Text(
            'Browse All',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
