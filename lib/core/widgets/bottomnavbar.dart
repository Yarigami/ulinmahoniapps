import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login/provider/auth_provider.dart';
import '../controller/launchwhatsapp_controller.dart';

class BottomNavBar extends ConsumerWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index, bool isLoggedIn) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/mybooking');
        break;
      case 2:
        launchWhatsApp();
        break;
      case 3:
        if (isLoggedIn) {
          context.go('/profile');
        } else {
          context.push('/login');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maroon = Color(0xFF800000);
    const darkGreen = Color(0xFF134E3A);

    final authState = ref.watch(authProvider);
    final bool isLoggedIn = authState.isLoggedIn;
    final user = authState.user.value;

    final List<Map<String, dynamic>> items = [
      {'icon': Icons.home, 'label': 'Utama'},
      {'icon': Icons.calendar_today, 'label': 'Pesanan Saya'},
      {'icon': Icons.phone, 'label': 'UM'},
      {
        'icon': isLoggedIn
            ? null
            : Icons.person, // hanya berikan IconData di sini
        'avatar': isLoggedIn
            ? CircleAvatar(
          radius: 12,
          backgroundImage: user?.profilePhotoUrl.isNotEmpty == true
              ? NetworkImage(user!.profilePhotoUrl)
              : null,
          child: user?.profilePhotoUrl.isEmpty == true
              ? const Icon(Icons.person, size: 16)
              : null,
        )
            : null,
        'label': isLoggedIn ? 'Profile' : 'Login',
        'isAvatar': isLoggedIn,
      },
    ];


    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List.generate(items.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Container(
              width: 1,
              height: 36,
              color: Colors.grey.shade300,
            );
          }

          final index = i ~/ 2;
          final item = items[index];
          final isSelected = index == currentIndex;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: InkWell(
                onTap: () => _onTap(context, index , isLoggedIn),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    item['isAvatar'] == true
                        ? item['avatar'] // gunakan avatar khusus
                        : Icon(
                      item['icon'],
                      color: isSelected ? darkGreen : maroon,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label'],
                      style: TextStyle(
                        color: isSelected ? darkGreen : maroon,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
