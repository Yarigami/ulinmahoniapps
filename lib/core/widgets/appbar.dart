import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/core/widgets/backbutton.dart'; // Pastikan path ini benar

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color backButtonColor;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    this.title = 'Default', // Nilai default adalah "Default"
    this.backgroundColor = const Color(0xFF005F21),
    this.textColor = Colors.white,
    this.backButtonColor = Colors.white,
    this.showBackButton = true, // Nilai default: tampilkan back button
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Tinggi AppBar standar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: showBackButton
          ? CustomBackButton(iconColor: backButtonColor)
          : null, // Tampilkan atau sembunyikan berdasarkan parameter
      title: Text(
        title,
        style: TextStyle( // Atur style untuk teks
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: textColor, // Warna teks putih
        ),
      ),
      centerTitle: false, // Judul rata kiri
    );
  }
}
