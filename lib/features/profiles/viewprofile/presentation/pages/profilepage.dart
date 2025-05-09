import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../../../../../core/widgets/appbar.dart';
import '../widgets/profile_menuitem_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../auth/login/provider/auth_providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool idvalue = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user.value;

    return MainLayout(
      showBottomNav: false,
      showNavBar: false,
      currentIndex: 3,
      child: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Profile", showBackButton: false),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF184D37),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundImage: user?.profilePhotoUrl != null &&
                                  user!.profilePhotoUrl.isNotEmpty
                                  ? NetworkImage(user.profilePhotoUrl)
                                  : AssetImage("assets/images/ulinhouse.jpg") as ImageProvider,
                              child: user?.profilePhotoUrl == null ||
                                  user!.profilePhotoUrl.isEmpty
                                  ? Icon(Icons.person, size: 36, color: Colors.white)
                                  : null,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.username ?? 'Nama Pengguna',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    user?.email ?? 'Email Pengguna',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.push('/updateprofile');
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      MenuItem(
                        icon: Icons.person_outline,
                        text: "My Account",
                        subText: "Make changes to your account",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {
                          context.push('/updateprofile');
                        },
                      ),
                      MenuItem(
                        icon: Icons.people_outline,
                        text: "Saved Beneficiary",
                        subText: "Manage your saved account",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {
                          context.push('/comingsoon');
                        },
                      ),
                      MenuItem(
                        icon: Icons.lock_outline,
                        text: "Face ID/Touch ID",
                        subText: "Manage your device security",
                        trailing: Switch(
                          value: idvalue,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            setState(() {
                              idvalue = value;
                            });
                          },
                        ),
                        onTap: () {
                          context.push('/comingsoon');
                        },
                      ),
                      MenuItem(
                        icon: Icons.security_outlined,
                        text: "Two-Factor Authentication",
                        subText: "Further secure your account for safety",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {
                          context.push('/comingsoon');
                        },
                      ),
                      MenuItem(
                        icon: Icons.logout,
                        text: "Log out",
                        subText: "Log out from your account",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () async {
                          await ref.read(authProvider.notifier).logout();
                          if (context.mounted) {
                            context.go('/welcome');
                          }
                        },
                      ),
                      SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "More",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      MenuItem(
                        icon: Icons.help_outline,
                        text: "Help & Support",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {
                          context.push('/help');
                        },
                      ),
                      MenuItem(
                        icon: Icons.info_outline,
                        text: "About App",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {
                          context.push('/comingsoon');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
