import 'package:flutter/material.dart';

Widget socialMedia(String imgPath) {
  return InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(36),
    child: Container(
      width: 72,
      height: 72,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Image.asset(imgPath),
    ),
  );
}