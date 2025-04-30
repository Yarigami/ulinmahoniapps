import 'package:flutter/material.dart';
import 'register.dart';
import 'package:ulinmahoniapps/main.dart';
import 'forgot_password.dart';

class LoggingIn extends StatefulWidget {
  const LoggingIn({super.key});

  @override
  State<LoggingIn> createState() => _LoggingInState();
}

class _LoggingInState extends State<LoggingIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                            foregroundColor: MaterialStateProperty.all(Colors.grey[600]),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainHomePage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green[800]),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
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
                                  color: Colors.grey,
                                  endIndent: spacing,
                                ),
                              ),
                              Text("Or Login With"),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
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
                    foregroundColor: MaterialStateProperty.all(Colors.green),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Don't have an account? ", style: TextStyle(color: Colors.black)),
                      Text("Register Now"),
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
      color: Colors.grey[300],
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: hint,
          border: InputBorder.none,
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
