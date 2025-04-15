import 'package:flutter/material.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String initialLanguage;

  const Navbar({
    super.key,
    this.initialLanguage = 'ID',
  });

  @override
  State<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
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
          elevation: 0,
          shadowColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/ulinmahonilogo.png',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          child: Text('Bahasa Indonesia'),
                        ),
                        DropdownMenuItem(
                          value: 'EN',
                          child: Text('English'),
                        ),
                      ],
                      icon: Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up   // ▲ saat terbuka
                            : Icons.arrow_drop_down, // ▼ saat tertutup
                        color: Color(0xFF006400), // Hijau tua
                      ),
                      dropdownColor: Colors.white,
                    );
                  },
                ),
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
