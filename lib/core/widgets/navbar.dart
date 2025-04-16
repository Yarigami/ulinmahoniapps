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
            padding: EdgeInsets.symmetric(horizontal: 3),
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
                        color: Color(0xFF006400),
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
