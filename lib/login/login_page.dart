import 'package:flutter/material.dart';
import 'register.dart';
import 'package:ulinmahoniapps/main.dart';
import 'forgot_password.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0), // Only padding here like Registering
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png", width: 150, height: 150),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Welcome back! Glad to see you again!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    _inputField("Enter your email"),
                    SizedBox(height: 16),
                    _inputField("Enter your password", obscure: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ForgotPassword()));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Color(0xFF6A707C)),
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text("Forgot Password?"),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainHomePage()),
                            (route) => false,
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF124624)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double spacing = constraints.maxWidth * 0.03;
                          return Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Color(0xFFE8ECF4),
                                  endIndent: spacing,
                                ),
                              ),
                              Text("Or Login With", style: TextStyle(color: Color(0xFF6A707C)),),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Color(0xFFE8ECF4),
                                  endIndent: spacing,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(),
                          // _socialMedia("assets/images/facebook.png"),
                          _socialMedia(icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue, size: 40,)),
                          _socialMedia(imgPath: "assets/images/google.webp"),
                          _socialMedia(icon:  Icon(FontAwesomeIcons.apple, color: Colors.black, size: 40,)),
                          // _socialMedia("assets/images/apple.png"),
                          // SizedBox(),
                          // SocialLoginButton(
                          //   buttonType: SocialLoginButtonType.google,
                          //   onPressed: () {},
                          // ),
                          // Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                          // Icon(FontAwesomeIcons.google),
                          // Icon(FontAwesomeIcons.apple, color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Registering()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    foregroundColor: MaterialStateProperty.all(Color(0xFF124624)),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Don't have an account? ", style: TextStyle(color: Color(0xFF1E232C))),
                      Text("Register Now", style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hint, {bool obscure = false}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFFE8ECF4),
        )
      ),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF8391A1)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _socialMedia({String? imgPath, Icon? icon}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: imgPath != null ?
        Image.asset(imgPath) : icon ?? Container()
      ),
    );
  }
}
