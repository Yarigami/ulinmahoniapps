import "package:flutter/material.dart";
import "package:link_text/link_text.dart";
import "logging_in.dart";
import 'register.dart';
import "../main.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground Content
          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: size.height * 0.2),
                    Flexible(
                      child: Column(
                        children: [
                          SizedBox(
                            // height: size.height * 0.15,
                            child: Image.asset("assets/images/logo.png"),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoggingIn()),
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
                                child: const Text("Login", style: TextStyle(fontSize: 20)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Registering()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                  foregroundColor: MaterialStateProperty.all(Colors.black),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.black, width: 1),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                                child: const Text("Register", style: TextStyle(fontSize: 20)),
                              ),
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
                            context,
                            MaterialPageRoute(builder: (context) => MainHomePage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          foregroundColor: MaterialStateProperty.all(Colors.green),
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text(
                          "Continue as a guest",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
