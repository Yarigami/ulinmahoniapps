import 'package:flutter/material.dart';
import 'password_changed.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Create New Password",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Your new password must be unique from those previously used.",
                      ),
                    ),
                    SizedBox(height: 20),
                    _inputField("New Password", obscure: true),
                    SizedBox(height: 16),
                    _inputField("Confirm Password", obscure: true),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PasswordChanged()));
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
                            "Reset Password",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
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
        color: Colors.grey[300],
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
}
