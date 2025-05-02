import 'package:flutter/material.dart';
import 'login_page.dart';

class Registering extends StatefulWidget {
  const Registering({super.key});

  @override
  State<Registering> createState() => _RegisteringState();
}

class _RegisteringState extends State<Registering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png", width: 150, height: 150),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Hello! Register to get started",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    _inputField("Username"),
                    SizedBox(height: 16),
                    _inputField("Email"),
                    SizedBox(height: 16),
                    _inputField("Password", obscure: true),
                    SizedBox(height: 16),
                    _inputField("Confirm password", obscure: true),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green[800]),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Register ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: LayoutBuilder(
                    //     builder: (context, constraints) {
                    //       double spacing = constraints.maxWidth * 0.03;
                    //       return Row(
                    //         children: [
                    //           Expanded(
                    //             child: Divider(
                    //               thickness: 1,
                    //               color: Colors.grey,
                    //               endIndent: spacing,
                    //             )
                    //           ),
                    //           Text("Or Login With"),
                    //           Expanded(
                    //             child: Divider(
                    //               thickness: 1,
                    //               color: Colors.grey,
                    //               endIndent: spacing,
                    //             )
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          _socialMedia("assets/images/facebook.png"),
                          _socialMedia("assets/images/google.png"),
                          _socialMedia("assets/images/apple.png"),
                          SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    foregroundColor: MaterialStateProperty.all(Colors.green),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: TextStyle(color: Colors.black)),
                      Text("Login Now"),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
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
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _socialMedia(String imgPath) {
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
        child: Image.asset(imgPath),
      ),
    );
  }
}
