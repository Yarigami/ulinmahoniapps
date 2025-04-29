import 'package:flutter/material.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String initialLanguage;

  const Navbar({
    Key? key,
    this.initialLanguage = 'ID',
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0); // AppBar tinggi 80
}

class _NavbarState extends State<Navbar> {
  late String selectedLanguage;
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: SizedBox(
              height: 55, // 2/3 dari 80
              width: 55,
              child: Image.asset(
                'assets/images/ulinmahonilogo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: StatefulBuilder(
                  builder: (context, setInnerState) {
                    return DropdownButton<String>(
                      value: selectedLanguage,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedLanguage = newValue;
                            isDropdownOpen = false;
                          });
                        }
                      },
                      onTap: () {
                        setInnerState(() {
                          isDropdownOpen = !isDropdownOpen;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'ID',
                          child: Text('ID'),
                        ),
                        DropdownMenuItem(
                          value: 'EN',
                          child: Text('EN'),
                        ),
                      ],
                      icon: Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: const Color(0xFF006400),
                      ),
                      dropdownColor: Colors.white,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Text(
                    'Masuk',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    ' / ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 30, // Mengatur tinggi tombol
                    child: ElevatedButton(
                      onPressed: () {
                        // Tambahkan logika untuk tombol Daftar di sini
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006400),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10), // Mengatur padding horizontal
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Tanpa border radius
                        ),
                      ),
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12, // Mengatur ukuran font
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 4,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
