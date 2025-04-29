import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layout/mainlayout.dart';
import '../../../../core/widgets/appbar.dart';
import '../../data/profile_data.dart';

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
      showBottomNav: true,
      showNavBar: true,
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
                      _buildMenuItem(
                        icon: Icons.person_outline,
                        text: "My Account",
                        subText: "Make changes to your account",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.people_outline,
                        text: "Saved Beneficiary",
                        subText: "Manage your saved account",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {},
                      ),
                      _buildMenuItem(
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
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.security_outlined,
                        text: "Two-Factor Authentication",
                        subText: "Further secure your account for safety",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.logout,
                        text: "Log out",
                        subText: "Further secure your account for safety",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {},
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
                      _buildMenuItem(
                        icon: Icons.help_outline,
                        text: "Help & Support",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.info_outline,
                        text: "About App",
                        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        onTap: () {},
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

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    String? subText,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.grey[600]),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subText != null)
                      Text(
                        subText,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
              ),
              trailing ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
