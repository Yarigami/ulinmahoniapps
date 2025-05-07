import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../provider/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginButtonEnabled = true;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/ulinmahonilogo.png", width: 150, height: 150),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Welcome back! Glad to see you again!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    _inputField("Enter your email", controller: _emailController),
                    SizedBox(height: 16),
                    _passwordField("Enter your password", controller: _passwordController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.push('/forgetpassword');
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
                        onPressed: _isLoginButtonEnabled
                            ? () async {
                          setState(() {
                            _isLoginButtonEnabled = false;
                          });

                          print('🔍 Tombol login ditekan');
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          try {
                            await ref.read(authProvider.notifier).login(email, password);
                            final isLoggedIn = ref.read(authProvider);

                            if (isLoggedIn) {
                              print('✅ Login berhasil');
                              // Memeriksa status login
                              checkIsLoggedIn();
                              context.go('/home');
                            } else {
                              print('❌ Login gagal');
                              _showErrorDialog('Login gagal. Periksa kembali data Anda.');
                            }
                          } catch (e) {
                            print('❌ Exception: $e');
                            _showErrorDialog('Terjadi kesalahan: $e');
                          } finally {
                            setState(() {
                              _isLoginButtonEnabled = true;
                            });
                          }
                        }
                            : null,
                        style: ButtonStyle(
                          backgroundColor: _isLoginButtonEnabled
                              ? MaterialStateProperty.all(Color(0xFF124624))
                              : MaterialStateProperty.all(Colors.grey),
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
                          _socialMedia("assets/images/facebook.png"),
                          _socialMedia("assets/images/google.png"),
                          _socialMedia("assets/images/apple.png"),
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
                    context.push('/register');
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

  Widget _inputField(String hint, {required TextEditingController controller}) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _passwordField(String hint, {required TextEditingController controller}) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      child: TextField(
        controller: controller,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void checkIsLoggedIn() {
    final isLoggedIn = ref.read(authProvider); // Membaca status login dari provider
    if (isLoggedIn) {
      print('User is logged in.');
    } else {
      print('User is not logged in.');
    }
  }
}
