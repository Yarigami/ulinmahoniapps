import 'package:flutter/material.dart';

class PaymentMethodItem extends StatefulWidget {
  final IconData icon;
  final String text;

  const PaymentMethodItem({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  _PaymentMethodItemState createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: Colors.grey),
              SizedBox(width: 8),
              Text(widget.text),
            ],
          ),
          Icon(Icons.check_box_outline_blank, color: Colors.grey),
        ],
      ),
    );
  }
}
