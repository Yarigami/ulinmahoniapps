import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login/provider/auth_provider.dart';

class Navbar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final String initialLanguage;

  const Navbar({
    Key? key,
    this.initialLanguage = 'ID',
  }) : super(key: key);

  @override
  ConsumerState<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0); // AppBar tinggi 80
}

class _NavbarState extends ConsumerState<Navbar> {
  late String selectedLanguage;
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user.value;

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
              // child: DropdownButtonHideUnderline(
              //   child: StatefulBuilder(
              //     builder: (context, setInnerState) {
              //       return DropdownButton<String>(
              //         value: selectedLanguage,
              //         onChanged: (String? newValue) {
              //           if (newValue != null) {
              //             setState(() {
              //               selectedLanguage = newValue;
              //               isDropdownOpen = false;
              //             });
              //           }
              //         },
              //         onTap: () {
              //           setInnerState(() {
              //             isDropdownOpen = !isDropdownOpen;
              //           });
              //         },
              //         items: const [
              //           DropdownMenuItem(
              //             value: 'ID',
              //             child: Text('ID'),
              //           ),
              //           DropdownMenuItem(
              //             value: 'EN',
              //             child: Text('EN'),
              //           ),
              //         ],
              //         icon: Icon(
              //           isDropdownOpen
              //               ? Icons.arrow_drop_up
              //               : Icons.arrow_drop_down,
              //           color: const Color(0xFF006400),
              //         ),
              //         dropdownColor: Colors.white,
              //       );
              //     },
              //   ),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // Cek status login untuk menampilkan elemen yang sesuai
                  if (!authState.isLoggedIn) ...[
                    TextButton(
                      onPressed: () {
                        context.push('/login');
                      },
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
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
                          context.push('/register');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF134E3A),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    if (user != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            context.go('/profile'); // Mengarahkan ke halaman profil saat CircleAvatar ditekan
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20, // Ukuran lingkaran
                                backgroundImage: NetworkImage(user.profilePhotoUrl), // Gambar profil pengguna
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
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
