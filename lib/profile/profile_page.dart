import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/login/welcome_page.dart';
import 'edit_profile.dart';
import '../help/help_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool idvalue = false;
  
  void _profilePage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EditProfile()));
  }

  void _helpPage(){
    Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const HelpPage()));
  }

  void _welcomPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()));
  }

  int language = 0; // eng = 0, indp = 1
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth * 0.8) / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: AppBar(
          backgroundColor: Color(0xFFd2c8ae),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xFF0d9488)),
                    width: double.infinity,
                    height: 100,
                    // color: Colors.green,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/images/placeholder.png"),
                                radius: 36,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 8),
                                    Text("User", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),),
                                    // SizedBox(height: 2),
                                    Text("User@gmail.com", style: TextStyle(fontSize: 12, color: Colors.white),),
                                  ],
                                ),
                              ),
                              // Center(
                              //   child:
                                IconButton(
                                  onPressed: (){},
                                  icon: Icon(
                                    Icons.create,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Card(
                color: Color(0xFFF5F2EA),
                // margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _menuItem(icon: Icons.person_outline, title: "My Account", subtitle: "Make changes to your account", onTap: _profilePage),
                      SizedBox(height: 8,),
                      _menuItem(icon: Icons.supervisor_account_outlined, title: "Saved Beneficiary", subtitle: "Manage your saved account"),
                      SizedBox(height: 8,),
                      Material(
                        color: Colors.white,
                        elevation: 4,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            width: double.infinity,
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.lock_outline,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    // backgroundImage: AssetImage("assets/images/placeholder.png"),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Face ID/Touch ID", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,),
                                          SizedBox(height: 4),
                                          Flexible(child: Text("Manage your device security", style: TextStyle(fontSize: 12, color: Colors.grey[600]), overflow: TextOverflow.ellipsis, maxLines: 2,)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Switch(
                                      value: idvalue,
                                      activeColor: Colors.green,
                                      thumbColor: WidgetStatePropertyAll(Colors.black),
                                      onChanged: (bool value){
                                        setState(() {
                                          idvalue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      _menuItem(icon: Icons.verified_user_outlined, title: "Two Factor Authentication", subtitle: "Further secure your account for safety"),
                      SizedBox(height: 8,),
                      _menuItem(icon: Icons.logout, title: "Log out", subtitle: "Further Secure your Account for safety", onTap: _welcomPage)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32,),
              Card(
                color: Color(0xFFF5F2EA),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("More",textAlign: TextAlign.left,),
                        ],
                      ),
                      SizedBox(height: 8,),
                      _menuItem(icon: Icons.support_agent, title: "Help & Support", onTap: _helpPage),
                      SizedBox(height: 8,),
                      _menuItem(icon: Icons.phone_android, title: "About App"),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ToggleButtons(
                          isSelected: [language == 0, language == 1],
                          onPressed: (int lang){
                            setState(() {
                              language = lang;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          selectedColor: Colors.white,
                          fillColor: Colors.green,
                          constraints: BoxConstraints(
                            minWidth: buttonWidth,
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              child: Text("English"),
                            ),
                            Container(
                              padding: EdgeInsets.all(12),
                              child: Text("Indonesia"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    bool hasSwitch = false,
    bool trailing = true,
    VoidCallback? onTap,
    ValueChanged<bool>? onSwitchChanged,
    bool idvalue = false, // Added idvalue to control the switch state
  }) {
    return Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(icon, color: Colors.black, size: 30),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      if (subtitle != null) ...[
                        SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (trailing)
                Center(
                  child: Icon(
                    Icons.arrow_forward,
                    size: 25,
                    color: Colors.black,
                  ),
                )
              else
                Center(
                  child: Switch(
                    value: idvalue,
                    activeColor: Colors.green,
                    thumbColor: MaterialStateProperty.all(Colors.black),
                    onChanged: (bool value) {
                      if (onSwitchChanged != null) {
                        onSwitchChanged(value); // Call the callback to handle the switch change
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

}
