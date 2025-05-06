import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layout/mainlayout.dart';
import '../../../../core/widgets/appbar.dart';
import '../../data/profile_data.dart';
import '../widgets/profile_menuitem_dart.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool idvalue = false;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBottomNav: false,
      showNavBar: false,
      currentIndex: 3,
      child: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Profile", showBackButton: false),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
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
                              backgroundImage: profileData.containsKey('image')
                                  ? profileData['image'] as AssetImage
                                  : AssetImage("assets/images/ulinhouse.jpg"),
                              radius: 36,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profileData['name'] ?? 'Nama',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    profileData['email'] ?? 'Email',
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
                        subText: "Further secure your account for safety",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {
                          context.push('/welcome');
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
