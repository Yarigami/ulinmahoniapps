import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/login/login_page.dart';
import 'edit_profile.dart';
import '../help_page.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool idvalue = false;
  
  void _profilePage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  void _helpPage(){
    Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const HelpPage()));
  }

  int language = 0; // eng = 0, indp = 1
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth * 0.8) / 2;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: AppBar(
          backgroundColor: Colors.green.shade700,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.green),
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
                SizedBox(height: 16,),
                Material(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: _profilePage,
                    child: SizedBox(
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
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.person_outline,
                                color: Colors.black,
                                size: 30,
                              ),
                              // backgroundImage: AssetImage("assets/images/placeholder.png"),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("My Account", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 4),
                                    Flexible(child: Text("Make changes to your account", style: TextStyle(fontSize: 12, color: Colors.grey[600]), overflow: TextOverflow.ellipsis, maxLines: 2,)),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.arrow_forward,
                                size: 25,
                                color: Colors.black,
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Material(
                  color: Colors.grey[300],
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
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.supervisor_account_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              // backgroundImage: AssetImage("assets/images/placeholder.png"),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Saved Beneficiary", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 4),
                                    Flexible(child: Text("Manage your saved account", style: TextStyle(fontSize: 12, color: Colors.grey[600]), overflow: TextOverflow.ellipsis, maxLines: 2,)),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: Colors.black,
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Material(
                  color: Colors.grey[300],
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
                              backgroundColor: Colors.grey[100],
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
                Material(
                  color: Colors.grey[300],
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
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.verified_user_outlined,
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
                                    Text("Two Factor Authentication", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 4),
                                    Flexible(child: Text("Further secure your account for safety", style: TextStyle(fontSize: 12, color: Colors.grey[600]), overflow: TextOverflow.ellipsis, maxLines: 2,)),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: Colors.black,
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Material(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage())
                      );
                    },
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
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.logout,
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
                                    Text("Log out", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 4),
                                    Flexible(child: Text("Further Secure your Account for safety", style: TextStyle(fontSize: 12, color: Colors.grey[600]), overflow: TextOverflow.ellipsis, maxLines: 2,)),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: Colors.black,
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("More",textAlign: TextAlign.left,),
                  ],
                ),
                SizedBox(height: 8,),
                Material(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: _helpPage,
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
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.support_agent,
                                color: Colors.black,
                                size: 30,
                              ),
                              // backgroundImage: AssetImage("assets/images/placeholder.png"),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Help & Support", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: Colors.black,
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Material(
                  color: Colors.grey[300],
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
                              radius: 25,
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.phone_android,
                                color: Colors.black,
                                size: 30,
                              ),
                              // backgroundImage: AssetImage("assets/images/placeholder.png"),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("About App", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: Colors.black,
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
          ),
        ),
      ),
    );
  }
}
